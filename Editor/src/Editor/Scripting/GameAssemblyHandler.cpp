#include "GameAssemblyHandler.h"

#include <Akkad/PlatformMacros.h>
#include <Akkad/Application/Application.h>
#include <Akkad/Scripting/LoadedGameAssembly.h>

namespace Akkad {
	bool GameAssemblyHandler::loadedGameAssembly = false;

	void GameAssemblyHandler::CompileGameAssembly(std::string path)
	{
		#ifdef AK_PLATFORM_WINDOWS
		path += "GameAssembly.sln";
		std::string command = "msbuild " + path;
		std::cout << command << std::endl;
		system(command.c_str());

		#endif // AK_PLATFORM_WINDOWS

	}

	void GameAssemblyHandler::LoadGameAssembly(std::string filename)
	{
		if (!loadedGameAssembly)
		{
			auto assembly = Application::GetInstance().m_LoadedGameAssembly;
			assembly->LoadAssembly(filename.c_str());
			assembly->Initialize(Application::GetInstance().m_ApplicationComponents);

			loadedGameAssembly = true;
		}

	}

	void GameAssemblyHandler::FreeGameAssembly()
	{
		if (loadedGameAssembly)
		{
			auto assembly = Application::GetInstance().m_LoadedGameAssembly;
			bool result = assembly->Free();
			if (result)
			{
				loadedGameAssembly = false;
			}
			
		}
	}

}