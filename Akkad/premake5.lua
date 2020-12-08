project "Akkad"
    kind "staticlib"
    language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
    objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")
    
    files
	{
		"src/**.h",
		"src/**.cpp",
    }

    excludes
    {
     "src/Akkad/Platforms/**.h",
     "src/Akkad/Platforms/**.cpp",
    }
    
    includedirs
	{
        "src",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.imgui}",
        "%{IncludeDir.glm}",
        "%{IncludeDir.stb}",
        "%{IncludeDir.spdlog}",
        "%{IncludeDir.entt}",
        "%{IncludeDir.json}",

    }
    
    links
	{
        "opengl32.lib",
        "Glad",
        "imgui",
        "spdlog"
    }
    
    filter "system:windows"
        systemversion "latest"
        
        files
        {
            "src/Akkad/Platforms/Desktop/Windows/**.h",
            "src/Akkad/Platforms/Desktop/Windows/**.cpp",
        }

        defines
        {
        }



filter "configurations:Debug"
    defines {"AK_DEBUG", "AK_ENABLE_IMGUI"} 
    runtime "Debug"
    symbols "on"

filter "configurations:Release"
    defines "AK_RELEASE"
    runtime "Release"
    optimize "on"