# ClickerWindow.rb
# fb-clicker
#
# Created by Juan Germán Castañeda Echevarría on 7/14/10.
# Copyright 2010 UNAM. All rights reserved.


class ClickerWindow < NSWindow

    attr_accessor :clickDelegate

    def awakeFromNib
        super
    end

    def sendEvent(event)
        super
        if @clickDelegate && @clickDelegate.is_active && event.type == NSLeftMouseUp && event.clickCount == 1
            @clickDelegate.userDidClickWindow(event)
        end
    end

end