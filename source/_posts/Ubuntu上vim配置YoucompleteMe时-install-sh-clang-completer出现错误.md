title: Ubuntu上vim配置YoucompleteMe时./install.sh --clang-completer出现错误
date: 2016-06-13 12:57:16
categories:
tags:
photos:
  - "https://images.pexels.com/photos/401686/pexels-photo-401686.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
---

### 问题描述
```
➜  YouCompleteMe git:(master) sudo ./install.sh --clang-completer
-- The C compiler identification is GNU 4.8.4
-- The CXX compiler identification is GNU 4.8.4
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++
-- Check for working CXX compiler: /usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Configuring incomplete, errors occurred!
See also "/tmp/ycm_build.gX46II/CMakeFiles/CMakeOutput.log".
Traceback (most recent call last):
  File "/home/vagrant/.vim/bundle/YouCompleteMe/third_party/ycmd/build.py", line 196, in <module>
    Main()
  File "/home/vagrant/.vim/bundle/YouCompleteMe/third_party/ycmd/build.py", line 189, in Main
    BuildYcmdLibs( GetCmakeArgs( args ) )
  File "/home/vagrant/.vim/bundle/YouCompleteMe/third_party/ycmd/build.py", line 147, in BuildYcmdLibs
    sh.cmake( *full_cmake_args, _out = sys.stdout )
  File "/home/vagrant/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/sh/sh.py", line 1021, in __call__
    return RunningCommand(cmd, call_args, stdin, stdout, stderr)
  File "/home/vagrant/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/sh/sh.py", line 486, in __init__
    self.wait()
  File "/home/vagrant/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/sh/sh.py", line 500, in wait
    self.handle_command_exit_code(exit_code)
  File "/home/vagrant/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/sh/sh.py", line 516, in handle_command_exit_code
    raise exc(self.ran, self.process.stdout, self.process.stderr)
sh.ErrorReturnCode_1:

  RAN: '/usr/bin/cmake -G Unix Makefiles -DUSE_CLANG_COMPLETER=ON /home/vagrant/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp'

  STDOUT:


  STDERR:
Your C++ compiler supports C++11, compiling in that mode.
CMake Error at /usr/share/cmake-2.8/Modules/FindPackageHandleStandardArgs.cmake:108 (message):
  Could NOT find PythonLibs (missing: PYTHON_LIBRARIES PYTHON_INCLUDE_DIRS)
  (Required is at least version "2.6")
Call Stack (most recent call first):
  /usr/share/cmake-2.8/Modules/FindPackageHandleStandardArgs.cmake:315 (_FPHSA_FAILURE_MESSAGE)
  /usr/share/cmake-2.8/Modules/FindPythonLibs.cmake:208 (FIND_PACKAGE_HANDLE_STANDARD_ARGS)
  BoostParts/CMakeLists.txt:30 (find_package)
```

### 解决办法

```
sudo apt-get install python-dev
```
