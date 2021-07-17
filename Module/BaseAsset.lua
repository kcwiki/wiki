local BaseData = require('Module:BaseData')
local Formatting = require('Module:Formatting')

local BaseAsset = BaseData{
	_image_wrapper_style = {display = "inline-block", position = "relative", overflow = "hidden", ['vertical-align'] = "middle"},
	_image_layer_style = {position = "absolute", ['line-height'] = "0px"},
	_grayscale_style = {filter = "grayscale(100%)", ['-webkit-filter'] = "grayscale(100%)"},
}

function BaseAsset:_add_layer(stack, layer, ship, args, link)
	stack:node(mw.html.create('span'):addClass('image-layer'):css(self._image_layer_style):css(layer.style):wikitext(Formatting:format_image{
	    layer.image,
	    -- caption = layer.caption or args.caption,
	    size = layer.size,
	    link = ""
	}))
end

function BaseAsset:_create_stack(image, grayscale)
	local stack = mw.html.create('span'):addClass('image-stack'):css(self._image_wrapper_style)
	if grayscale then
		stack:node(mw.html.create('span'):addClass('grayscale-wrapper'):css(self._grayscale_style):wikitext(image))
	else
		stack:wikitext(image)
	end
	return stack
end

function BaseAsset:Asset(args)
	local object = self:create_object(args)
	if args.mode == "source" then
		return self:get_source(object, args) or Formatting:error_span("No asset could be found.")
	elseif args.link then
		if args.link == "nil" then
			return self:get(object, args, nil)
		elseif args.link == "false" then
			return self:get(object, args, false)
		else
			return self:get(object, args, args.link)
		end
	else
		return self:get(object, args, object:link())
	end
end

return BaseAsset