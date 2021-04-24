# Compiler-Design
I am using FLEX tool to design a simple Compiler

# How to install Flex on Linux?
Just type in cmd:
```
sudo apt-get install flex
sudo apt-get update
```

# How to install Flex on Windows?
Just go to this  <a href="http://gnuwin32.sourceforge.net/packages/flex.htm" target="_blank">Official Site</a>
Download the complete package
After Downloading,install it. Then in searchBar , Type:
```
edit the system environment variables
```
Go to Environment Variable, Under System Variables , Choose Path  
Now it will pop up Edit Environment Variable. Then add Two path
one is ```bin folder of MinGW``` and another is ```bin folder of GnuWin32```

# How to run?
Flex file's extensions are ```.l``` or ```.lex```
run command prompt, where your .l or .lex file is located
## First approach
In cmd Type :<br>
```
flex filename.l
gcc lex.yy.c
./a.out
```

#### Disadvantage of this approach:
you have to create one folder to execute one .lex file
So if you have multiple .l or .lex file, have to create different different folder
why? The reason is: for each .l or .lex file , everytime a.out file will be created
Now windows doesn't support duplicate file in same folder,so it will try to merge & the previous a.out file will be lost

## Second approach/Best approach
generally Flex programme is designed with default ```a.out``` file But if You can change the name of Object file , then automatically the executable file name will be changed

In CMD Type:
```
flex fileName.l
gcc lex.yy.c -o Anything
./Anything.exe
```

