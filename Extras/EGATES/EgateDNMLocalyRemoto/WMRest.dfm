object WebModule1: TWebModule1
  Actions = <
    item
      Default = True
      Name = 'default'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 273
  Width = 403
end
