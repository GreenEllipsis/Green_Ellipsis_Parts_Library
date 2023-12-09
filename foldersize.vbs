'when launched from the send to menu (with the target
' Wscript.exe "folderize.vbs"), this Script
' creates a folder with the same name as the selected File
' and moves the selected file to the folder
Set objShell = CreateObject("Shell.Application")
Set objFSO = CreateObject("Scripting.FileSystemObject")
templateFile = "template.yaml"
Dim yamlFile 
' Get the selected file path
For Each strFile In WScript.Arguments
    If objFSO.FileExists(strFile) Then
        strFilePath = strFile
		' Create a folder with the same name as the file
		strFolderName = objFSO.GetBaseName(strFilePath)
		strFolderPath = objFSO.GetParentFolderName(strFilePath) & "\" & strFolderName
		yamlFile = strFolderPath & "\" & Left(strFolderName, 10) & ".yaml"
		If Not objFSO.FolderExists(strFolderPath) Then
			objFSO.CreateFolder(strFolderPath)
		End If
		' Move the file into the created folder
		objFSO.MoveFile strFilePath, strFolderPath & "\"
		' Copy the template file into the created folder
		objFSO.CopyFile templateFile, yamlFile
		' update last updated
		UpdateYAMLFile yamlFile
    End If
Next

If strFilePath = "" Then
    WScript.Echo "No valid file selected."
    WScript.Quit
End If



Function UpdateYAMLFile(filePath)
    Dim originalContent, newContent
    Dim objFSO, objFile, regex, matches

    ' Check if the file exists
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    If Not objFSO.FileExists(filePath) Then
        WScript.Echo "File not found: " & filePath
        WScript.Quit
    End If

    ' Read the original content of the YAML file
    Set objFile = objFSO.OpenTextFile(filePath, 1)
    originalContent = objFile.ReadAll
    objFile.Close

    ' Get the current date in YYYY-MM-DD format
    currentDate = FormatDateTime(Now, 2)

    ' Find and replace the "last updated:" line using regex
    Set regex = New RegExp
    regex.Global = True
    regex.IgnoreCase = True
    regex.Pattern = "(last updated:)\s*(.*)"

    Set matches = regex.Execute(originalContent)
    If matches.Count > 0 Then
        ' Replace the existing "last updated:" line with the new one
        newContent = regex.Replace(originalContent, "$1 " & currentDate)
    Else
        ' If "last updated:" is not found, add it to the end of the file
        newContent = originalContent & vbCrLf & "last updated: " & currentDate
    End If

    ' Write the updated content back to the file
    Set objFile = objFSO.OpenTextFile(filePath, 2)
    objFile.Write newContent
    objFile.Close
End Function

