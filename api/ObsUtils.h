#pragma once
#include <string>
#include <vector>

typedef void(*enum_window_callback)(void* ptr,const char* name,const char* window);

//ö����Ϸ����
void EnumGameWindow(enum_window_callback callback,void * ptr);

//ö�ٴ���
void EnumWindow(enum_window_callback callback, void * ptr);

typedef void(*enum_device_callback)(void* ptr, bool isVideo,const char* name, const char* id);

//ö������Ƶ�豸
void EnumDevice(enum_device_callback callback, void * ptr);

//ö����Ļ
typedef void(*enum_monitor_callback)(void* ptr, const char* name, int id);

void EnumMonitor(enum_monitor_callback callback, void * ptr);

struct WindowInfo
{
    WindowInfo(const char* _name,const char* _window)
        :name(_name),window(_window)
    {
    }
    std::string name;
    std::string window;
};

std::vector<WindowInfo> GetWindowInfo(bool isGame);

#include "UIlib.h"

std::string ToUtf8(const wchar_t* unicode,int len=-1);
DuiLib::CDuiString FromUtf8(const char* utf8);

std::string GenerateSourceName(const  std::string &base);

std::string ObsErrorToText(int code);
