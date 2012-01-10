Deface::Override.new(:virtual_path => "spree/shared/_footer",
                     :name => "converted_footer_right_920701005",
                     :insert_after => "[data-hook='footer_right'], #footer_right[data-hook]",
                     :text => "
    <%= javascript_include_tag(\"jquery.rating.js\") %>
    <%= javascript_tag(\"$(document).ready(function(){$('.stars').rating({required:true});});\") %>
    ",
                     :disabled => false)
