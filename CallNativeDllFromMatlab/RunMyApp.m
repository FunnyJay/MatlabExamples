function RunMyApp
    DLL_FILE_NAME = 'ClassLibrary1.dll';
    
    try
        % .NETランタイムの確認
        if ~NET.isNETSupported
            ME = MException('Matlab:RunMyApp','サポート対象の Microsoft .NET Frameworkが見つかりません');
            throw(ME);
        end
        
        dllpath = which(DLL_FILE_NAME);
        if isempty(dllpath)
            ME = MException('Matlab:RunMyApp',[DLL_FILE_NAME, 'が見つかりません']);
            throw(ME);
        end
        
        % .NETアセンブリを読み込んで関数を呼び出す   
        NET.addAssembly(dllpath);
        app = ClassLibrary1.MyClass;
        app.TopMost = true;
        app.ShowDialog;
    catch ex
        if(isa(ex, 'NET.NetException'))
            error(ex.ExceptionObject.Message);
        else
            error(ex.message);
        end
    end
end