# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 3.25

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"

# The command to remove a file.
RM = "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe" -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = D:\student_helper\windows

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = D:\student_helper\build

# Include any dependencies generated for this target.
include runner/CMakeFiles/student_helper.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include runner/CMakeFiles/student_helper.dir/compiler_depend.make

# Include the progress variables for this target.
include runner/CMakeFiles/student_helper.dir/progress.make

# Include the compile flags for this target's objects.
include runner/CMakeFiles/student_helper.dir/flags.make

runner/CMakeFiles/student_helper.dir/flutter_window.cpp.obj: runner/CMakeFiles/student_helper.dir/flags.make
runner/CMakeFiles/student_helper.dir/flutter_window.cpp.obj: runner/CMakeFiles/student_helper.dir/includes_CXX.rsp
runner/CMakeFiles/student_helper.dir/flutter_window.cpp.obj: D:/student_helper/windows/runner/flutter_window.cpp
runner/CMakeFiles/student_helper.dir/flutter_window.cpp.obj: runner/CMakeFiles/student_helper.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=D:\student_helper\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object runner/CMakeFiles/student_helper.dir/flutter_window.cpp.obj"
	cd /d D:\student_helper\build\runner && C:\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT runner/CMakeFiles/student_helper.dir/flutter_window.cpp.obj -MF CMakeFiles\student_helper.dir\flutter_window.cpp.obj.d -o CMakeFiles\student_helper.dir\flutter_window.cpp.obj -c D:\student_helper\windows\runner\flutter_window.cpp

runner/CMakeFiles/student_helper.dir/flutter_window.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/student_helper.dir/flutter_window.cpp.i"
	cd /d D:\student_helper\build\runner && C:\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E D:\student_helper\windows\runner\flutter_window.cpp > CMakeFiles\student_helper.dir\flutter_window.cpp.i

runner/CMakeFiles/student_helper.dir/flutter_window.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/student_helper.dir/flutter_window.cpp.s"
	cd /d D:\student_helper\build\runner && C:\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S D:\student_helper\windows\runner\flutter_window.cpp -o CMakeFiles\student_helper.dir\flutter_window.cpp.s

runner/CMakeFiles/student_helper.dir/main.cpp.obj: runner/CMakeFiles/student_helper.dir/flags.make
runner/CMakeFiles/student_helper.dir/main.cpp.obj: runner/CMakeFiles/student_helper.dir/includes_CXX.rsp
runner/CMakeFiles/student_helper.dir/main.cpp.obj: D:/student_helper/windows/runner/main.cpp
runner/CMakeFiles/student_helper.dir/main.cpp.obj: runner/CMakeFiles/student_helper.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=D:\student_helper\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object runner/CMakeFiles/student_helper.dir/main.cpp.obj"
	cd /d D:\student_helper\build\runner && C:\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT runner/CMakeFiles/student_helper.dir/main.cpp.obj -MF CMakeFiles\student_helper.dir\main.cpp.obj.d -o CMakeFiles\student_helper.dir\main.cpp.obj -c D:\student_helper\windows\runner\main.cpp

runner/CMakeFiles/student_helper.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/student_helper.dir/main.cpp.i"
	cd /d D:\student_helper\build\runner && C:\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E D:\student_helper\windows\runner\main.cpp > CMakeFiles\student_helper.dir\main.cpp.i

runner/CMakeFiles/student_helper.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/student_helper.dir/main.cpp.s"
	cd /d D:\student_helper\build\runner && C:\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S D:\student_helper\windows\runner\main.cpp -o CMakeFiles\student_helper.dir\main.cpp.s

runner/CMakeFiles/student_helper.dir/utils.cpp.obj: runner/CMakeFiles/student_helper.dir/flags.make
runner/CMakeFiles/student_helper.dir/utils.cpp.obj: runner/CMakeFiles/student_helper.dir/includes_CXX.rsp
runner/CMakeFiles/student_helper.dir/utils.cpp.obj: D:/student_helper/windows/runner/utils.cpp
runner/CMakeFiles/student_helper.dir/utils.cpp.obj: runner/CMakeFiles/student_helper.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=D:\student_helper\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object runner/CMakeFiles/student_helper.dir/utils.cpp.obj"
	cd /d D:\student_helper\build\runner && C:\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT runner/CMakeFiles/student_helper.dir/utils.cpp.obj -MF CMakeFiles\student_helper.dir\utils.cpp.obj.d -o CMakeFiles\student_helper.dir\utils.cpp.obj -c D:\student_helper\windows\runner\utils.cpp

runner/CMakeFiles/student_helper.dir/utils.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/student_helper.dir/utils.cpp.i"
	cd /d D:\student_helper\build\runner && C:\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E D:\student_helper\windows\runner\utils.cpp > CMakeFiles\student_helper.dir\utils.cpp.i

runner/CMakeFiles/student_helper.dir/utils.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/student_helper.dir/utils.cpp.s"
	cd /d D:\student_helper\build\runner && C:\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S D:\student_helper\windows\runner\utils.cpp -o CMakeFiles\student_helper.dir\utils.cpp.s

runner/CMakeFiles/student_helper.dir/win32_window.cpp.obj: runner/CMakeFiles/student_helper.dir/flags.make
runner/CMakeFiles/student_helper.dir/win32_window.cpp.obj: runner/CMakeFiles/student_helper.dir/includes_CXX.rsp
runner/CMakeFiles/student_helper.dir/win32_window.cpp.obj: D:/student_helper/windows/runner/win32_window.cpp
runner/CMakeFiles/student_helper.dir/win32_window.cpp.obj: runner/CMakeFiles/student_helper.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=D:\student_helper\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object runner/CMakeFiles/student_helper.dir/win32_window.cpp.obj"
	cd /d D:\student_helper\build\runner && C:\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT runner/CMakeFiles/student_helper.dir/win32_window.cpp.obj -MF CMakeFiles\student_helper.dir\win32_window.cpp.obj.d -o CMakeFiles\student_helper.dir\win32_window.cpp.obj -c D:\student_helper\windows\runner\win32_window.cpp

runner/CMakeFiles/student_helper.dir/win32_window.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/student_helper.dir/win32_window.cpp.i"
	cd /d D:\student_helper\build\runner && C:\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E D:\student_helper\windows\runner\win32_window.cpp > CMakeFiles\student_helper.dir\win32_window.cpp.i

runner/CMakeFiles/student_helper.dir/win32_window.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/student_helper.dir/win32_window.cpp.s"
	cd /d D:\student_helper\build\runner && C:\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S D:\student_helper\windows\runner\win32_window.cpp -o CMakeFiles\student_helper.dir\win32_window.cpp.s

runner/CMakeFiles/student_helper.dir/__/flutter/generated_plugin_registrant.cc.obj: runner/CMakeFiles/student_helper.dir/flags.make
runner/CMakeFiles/student_helper.dir/__/flutter/generated_plugin_registrant.cc.obj: runner/CMakeFiles/student_helper.dir/includes_CXX.rsp
runner/CMakeFiles/student_helper.dir/__/flutter/generated_plugin_registrant.cc.obj: D:/student_helper/windows/flutter/generated_plugin_registrant.cc
runner/CMakeFiles/student_helper.dir/__/flutter/generated_plugin_registrant.cc.obj: runner/CMakeFiles/student_helper.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=D:\student_helper\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object runner/CMakeFiles/student_helper.dir/__/flutter/generated_plugin_registrant.cc.obj"
	cd /d D:\student_helper\build\runner && C:\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT runner/CMakeFiles/student_helper.dir/__/flutter/generated_plugin_registrant.cc.obj -MF CMakeFiles\student_helper.dir\__\flutter\generated_plugin_registrant.cc.obj.d -o CMakeFiles\student_helper.dir\__\flutter\generated_plugin_registrant.cc.obj -c D:\student_helper\windows\flutter\generated_plugin_registrant.cc

runner/CMakeFiles/student_helper.dir/__/flutter/generated_plugin_registrant.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/student_helper.dir/__/flutter/generated_plugin_registrant.cc.i"
	cd /d D:\student_helper\build\runner && C:\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E D:\student_helper\windows\flutter\generated_plugin_registrant.cc > CMakeFiles\student_helper.dir\__\flutter\generated_plugin_registrant.cc.i

runner/CMakeFiles/student_helper.dir/__/flutter/generated_plugin_registrant.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/student_helper.dir/__/flutter/generated_plugin_registrant.cc.s"
	cd /d D:\student_helper\build\runner && C:\MinGW\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S D:\student_helper\windows\flutter\generated_plugin_registrant.cc -o CMakeFiles\student_helper.dir\__\flutter\generated_plugin_registrant.cc.s

runner/CMakeFiles/student_helper.dir/Runner.rc.obj: runner/CMakeFiles/student_helper.dir/flags.make
runner/CMakeFiles/student_helper.dir/Runner.rc.obj: D:/student_helper/windows/runner/Runner.rc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=D:\student_helper\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building RC object runner/CMakeFiles/student_helper.dir/Runner.rc.obj"
	cd /d D:\student_helper\build\runner && C:\MinGW\bin\windres.exe -O coff $(RC_DEFINES) $(RC_INCLUDES) $(RC_FLAGS) D:\student_helper\windows\runner\Runner.rc CMakeFiles\student_helper.dir\Runner.rc.obj

# Object files for target student_helper
student_helper_OBJECTS = \
"CMakeFiles/student_helper.dir/flutter_window.cpp.obj" \
"CMakeFiles/student_helper.dir/main.cpp.obj" \
"CMakeFiles/student_helper.dir/utils.cpp.obj" \
"CMakeFiles/student_helper.dir/win32_window.cpp.obj" \
"CMakeFiles/student_helper.dir/__/flutter/generated_plugin_registrant.cc.obj" \
"CMakeFiles/student_helper.dir/Runner.rc.obj"

# External object files for target student_helper
student_helper_EXTERNAL_OBJECTS =

runner/student_helper.exe: runner/CMakeFiles/student_helper.dir/flutter_window.cpp.obj
runner/student_helper.exe: runner/CMakeFiles/student_helper.dir/main.cpp.obj
runner/student_helper.exe: runner/CMakeFiles/student_helper.dir/utils.cpp.obj
runner/student_helper.exe: runner/CMakeFiles/student_helper.dir/win32_window.cpp.obj
runner/student_helper.exe: runner/CMakeFiles/student_helper.dir/__/flutter/generated_plugin_registrant.cc.obj
runner/student_helper.exe: runner/CMakeFiles/student_helper.dir/Runner.rc.obj
runner/student_helper.exe: runner/CMakeFiles/student_helper.dir/build.make
runner/student_helper.exe: flutter/libflutter_wrapper_app.a
runner/student_helper.exe: D:/student_helper/windows/flutter/ephemeral/flutter_windows.dll.lib
runner/student_helper.exe: D:/student_helper/windows/runner/runner.exe.manifest
runner/student_helper.exe: runner/CMakeFiles/student_helper.dir/linkLibs.rsp
runner/student_helper.exe: runner/CMakeFiles/student_helper.dir/objects1
runner/student_helper.exe: runner/CMakeFiles/student_helper.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=D:\student_helper\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Linking CXX executable student_helper.exe"
	cd /d D:\student_helper\build\runner && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\student_helper.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
runner/CMakeFiles/student_helper.dir/build: runner/student_helper.exe
.PHONY : runner/CMakeFiles/student_helper.dir/build

runner/CMakeFiles/student_helper.dir/clean:
	cd /d D:\student_helper\build\runner && $(CMAKE_COMMAND) -P CMakeFiles\student_helper.dir\cmake_clean.cmake
.PHONY : runner/CMakeFiles/student_helper.dir/clean

runner/CMakeFiles/student_helper.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" D:\student_helper\windows D:\student_helper\windows\runner D:\student_helper\build D:\student_helper\build\runner D:\student_helper\build\runner\CMakeFiles\student_helper.dir\DependInfo.cmake --color=$(COLOR)
.PHONY : runner/CMakeFiles/student_helper.dir/depend
