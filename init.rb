require 'endless_pageless_helper'

# ActionView::Helpers::AssetTagHelper.register_javascript_include_default('paginator')

ActionView::Base.send(:include, EndlessPagelessHelper)
