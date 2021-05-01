---
-- Wrap (args, frame?) -> wikitext function into a frame -> wikitext function.
--
-- [[Category:Todo]]: actually should provide a react-like view library.
--

local _ = require('Module:Core')

local DummyFrame = {}

function DummyFrame:preprocess(x)
  return x
end

return function(render, test)
  return {
    render = function(frame)
      return render(frame and _.getTemplateArgs(frame) or {}, frame)
    end,
    test = function()
      return render(test, DummyFrame)
    end,
  }
end