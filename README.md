<div align="center">
    <h1>
        main.sh User's guide
    </h1>
</div>

> Allows you to **easily** compile and/or run c++ code on the terminal.
>
>  Simply adds `alias youAliasName="sh yourFilePath/runCpp20.sh"` to your shell
> configuration file.

​	In order to use this command, you'll need at least one argument, the path of your
current directory

if you have an 'assets' folder, it will also compile the files in that folder.

## Compile and run

### - Compile all files and run

```shell
yourAliasName
```

### - Compile, ignore file(s) and run

```shell
yourAliasName ignoredFile1.cpp ... ignoredFilesN.cpp
```



## Compile

### - You want to compile all of the .cpp files in your directory.

```shell
yourAliasName -c
```

### - You want to ignore files.

```shell
yourAliasName -c ignoredFile1.cpp ... ignoredFilesN.cpp
```

## Run

This senario is the complex one.

There’s a lot of different cases.

## - The compiled file 'mainTqt' already exists.

```shell
yourAliasName -r
```

## - The compiled file 'mainTqt' does not exist.

```shell
yourAliasName -r
```

```shell
yourPath/mainTqt does not exist.
Do you want to compile and run ? (y/n) :
```

### - If you want to compile then run

```shell
Do you want to compile and run ? (y/n) : y
Do you not want to compile certain files ? (y/n) :
```

#### - If you want to ignore files:

```shell
Do you not want to compile certain files ? (y/n) : y
Name(s) of the file(s) that you want to ignore : ignoredFile1.cpp ignoredFile2.cpp

----- Compiling...
ignoredFile1.cpp ignored.
ignoredFile2.cpp ignored.
Compilation of othersFilesNames into mainTqt.
----- Compiling complete.
```

#### - If you don't  want to ignore files:

```shell
Do you not want to compile certain files ? (y/n) : n

----- Compiling...
Compilation of allCppFilesNames into mainTqt.
----- Compiling complete.
```
