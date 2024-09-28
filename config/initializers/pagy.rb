require 'pagy/extras/metadata'
require 'pagy/extras/headers'

Pagy::DEFAULT[:items] = 25  # Items per page
Pagy::DEFAULT[:metadata] = [:page, :items, :count, :pages, :prev, :next]
