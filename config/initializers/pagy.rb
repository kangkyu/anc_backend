require 'pagy/extras/metadata'
require 'pagy/extras/headers'
require 'pagy/extras/overflow'

Pagy::DEFAULT[:items] = 25  # Items per page
Pagy::DEFAULT[:metadata] = [:page, :items, :count, :pages, :prev, :next]

# Better user experience handled automatically
Pagy::DEFAULT[:overflow] = :last_page
