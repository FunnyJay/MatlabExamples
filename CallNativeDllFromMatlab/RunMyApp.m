function RunMyApp
    DLL_FILE_NAME = 'ClassLibrary1.dll';
    
    try
        % .NET�����^�C���̊m�F
        if ~NET.isNETSupported
            ME = MException('Matlab:RunMyApp','�T�|�[�g�Ώۂ� Microsoft .NET Framework��������܂���');
            throw(ME);
        end
        
        dllpath = which(DLL_FILE_NAME);
        if isempty(dllpath)
            ME = MException('Matlab:RunMyApp',[DLL_FILE_NAME, '��������܂���']);
            throw(ME);
        end
        
        % .NET�A�Z���u����ǂݍ���Ŋ֐����Ăяo��   
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