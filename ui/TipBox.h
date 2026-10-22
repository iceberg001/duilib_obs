#pragma once

class CTipBox :public WindowImplBase
{
public:
    CTipBox();
    ~CTipBox();

    static void ShowTip(LPCTSTR text);

    void ShowDialog(LPCTSTR text);

    void SetText(LPCTSTR text);

    virtual CDuiString GetSkinFile() {
        return _T("TipBox.xml");
    }

    virtual void OnFinalMessage(HWND hWnd) {
        delete this;
    }

    virtual void Notify(TNotifyUI& msg);
    LPCTSTR GetWindowClassName() const { return _T("ObsGuiFoundation"); }

    void InitWindow()
    {
        RECT corner = { 5,3,5,7 };
        RECT hole = { 0,0,0,0 };
        m_shadow.SetImage(_T("image/window_shadow.png"), corner, hole);
        m_shadow.Create(m_hWnd);
    }
private:
    CWndShadow m_shadow;
    static CTipBox* s_lastTipBox;
};

