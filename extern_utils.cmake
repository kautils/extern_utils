if(NOT DEFINED KAUTIL_THIRD_PARTY_DIR)
    set(KAUTIL_THIRD_PARTY_DIR ${CMAKE_BINARY_DIR})
    file(MAKE_DIRECTORY "${KAUTIL_THIRD_PARTY_DIR}")
endif()

macro(git_clone url)
    get_filename_component(file_name ${url} NAME)
    if(NOT EXISTS ${KAUTIL_THIRD_PARTY_DIR}/kautil_cmake/${file_name})
        file(DOWNLOAD ${url} "${KAUTIL_THIRD_PARTY_DIR}/kautil_cmake/${file_name}")
    endif()
    include("${KAUTIL_THIRD_PARTY_DIR}/kautil_cmake/${file_name}")
    unset(file_name)
endmacro()

git_clone(https://raw.githubusercontent.com/kautils/CMakeLibrarytemplate/v0.0.1/CMakeLibrarytemplate.cmake)

set(module_name extern_utils)
unset(srcs)
file(GLOB srcs ${CMAKE_CURRENT_LIST_DIR}/*.cc)
set(${module_name}_common_pref
    #DEBUG_VERBOSE
    MODULE_PREFIX kautil extern_utils
    MODULE_NAME ${module_name}
    INCLUDES $<INSTALL_INTERFACE:include> $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}> ${CMAKE_CURRENT_LIST_DIR} 
    SOURCES ${srcs}
    #LINK_LIBS 
    EXPORT_NAME_PREFIX ${PROJECT_NAME}
    EXPORT_VERSION ${PROJECT_VERSION}
    EXPORT_VERSION_COMPATIBILITY AnyNewerVersion
        
    DESTINATION_INCLUDE_DIR include kautil extern_utils
    DESTINATION_CMAKE_DIR cmake
    DESTINATION_LIB_DIR lib
)

install(FILES ${CMAKE_CURRENT_LIST_DIR}/scope.hpp DESTINATION include/kautil/extern_utils/scope)
install(FILES ${CMAKE_CURRENT_LIST_DIR}/iterator.hpp DESTINATION include/kautil/extern_utils/iterator)
CMakeLibraryTemplate(${module_name} EXPORT_LIB_TYPE interface ${${module_name}_common_pref} )


