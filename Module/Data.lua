local _ = require('Module:Core')

return {
  load = function (...)
    return mw.loadData(_.join({ 'Module:Data', unpack(arg) }, '/'))
  end
}