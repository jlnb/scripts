# Rename files with unallowed names for exFAT or NTFS file system

Unallowed characters are (according to the QNAP website):

```
\/:*?"<>|
```

Especially the character ':' occurs frequently in backups of my e-mails (more than 5000 files). Because I refused to rename all those files manually, I came up with a little bash script.

For test purposes, do only use the 'testscript.sh' file. This makes sure that you don't accidentally rename the testfiles in the respective folder. Once these files are renamed, there are no files to be tested at all. Once the 'testscript.sh' ran, you can reset the test environment to the original conditions by running the 'resetTestEnvironment.sh' script.

NOTE: I am not aware what happens if this repository is cloned to a OS that uses an exFAT or NTFS file system. Maybe all testfiles are renamed automatically? In this case no tests could be done.
