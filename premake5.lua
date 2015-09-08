-- premake5.lua

local BUILD_DIR = (".build/" .. _ACTION)

workspace "imgui-samples"
   configurations { "Debug", "Release" }
   location (BUILD_DIR)
   -- platforms { "x32", "x64" }

   -- filter { "platforms:x32" }
   --    architecture "x32"

   -- filter { "platforms:x64" }
   --    architecture "x64"

   filter "configurations:Debug"
      defines { "DEBUG" }
      flags { "Symbols" }

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"

-- filter "action:vs2010"
-- filter "action:vs*"
--   defines { "VISUAL_STUDIO_2005" }      

-- filter { "Debug", "kind:SharedLib or StaticLib" }
--   targetsuffix "_d"

-- filter "system:not windows"
--   defines { "NOT_WINDOWS" }

-- filter "files:**.png"
--   buildaction "Embed" -- Embed the file into the target binary as a resource.

project "libimgui"
   kind "StaticLib"
   location (BUILD_DIR .. "/libimgui")
   language "C++"
   targetdir (BUILD_DIR .. "/lib/%{cfg.buildcfg}")

   includedirs  {"./"}

   files { "./*.cpp", "./*.h" }



project "opengl3_example"
   kind "ConsoleApp"
   location (BUILD_DIR .. "/opengl3_example")
   language "C++"
   targetdir (BUILD_DIR .. "/%{cfg.buildcfg}")

   -- defines { "" }   

   includedirs  {
      "./examples/libs/glfw/include/",
      "./examples/libs/gl3w/",
      "./",
      "../../"
   }
   
   libdirs { BUILD_DIR .. "/lib/%{cfg.buildcfg}" }
   links { 
      "libimgui", 
      "./examples/libs/glfw/lib-vc2010-32/glfw3.lib",
      "opengl32"
   }

   files { 
      "./examples/opengl3_example/**.h", 
      "./examples/opengl3_example/**.cpp", 
      "./examples/libs/gl3w/**.*" }

