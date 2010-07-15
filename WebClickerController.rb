# WebClickerController.rb
# fb-clicker
#
# Created by Juan Germán Castañeda Echevarría on 7/14/10.
# Copyright 2010 UNAM. All rights reserved.


class WebClickerController < NSWindowController
    attr_writer :webview, :window
    attr_writer :width, :height
    attr_accessor :is_active
    
    def awakeFromNib
        @webview.mainFrame.loadRequest(
            NSURLRequest.requestWithURL(
                #NSURL.URLWithString("http://jazzothegreat.com/sketch.html")))
                NSURL.URLWithString("http://apps.facebook.com/onthefarm/")))
    end
    
    def userDidClickWindow(event)
        loc = CGEventGetLocation(event.CGEvent)
        self.performSelectorInBackground('clicks:', withObject:loc)
    end
    
    private
    
    def postMouseEvent(button, type, point)
        theEvent = CGEventCreateMouseEvent(nil, type, point, button);
        CGEventSetType(theEvent, type);
        kCGHIDEventTap = 0
        CGEventPost(kCGHIDEventTap, theEvent);
        CFRelease(theEvent);
    end
    
    def clicks(point)
        width = @width.integerValue
        height = @height.integerValue
        
        width.times do |i|
            newPoint = point
            height.times do |j|
                return if !@is_active
                newPoint = click(newPoint) unless i == 0 && j == 0 #point clicked by user
                newPoint = CGPointMake(newPoint.x - 15, newPoint.y - 8)
            end
            point = CGPointMake(point.x + 15, point.y - 8 + 0.7)
        end
    end

    def click(point) 
        kCGMouseButtonLeft = 0
        kCGEventMouseMoved = 5
        kCGEventLeftMouseDown = 1
        kCGEventLeftMouseUp = 2
        CGDisplayMoveCursorToPoint(CGMainDisplayID(), point)
        point = CGPointMake(point.x, point.y + 0.7)
        CGDisplayMoveCursorToPoint(CGMainDisplayID(), point)
        sleep(0.1)
        postMouseEvent(kCGMouseButtonLeft, kCGEventLeftMouseDown, point);
        postMouseEvent(kCGMouseButtonLeft, kCGEventLeftMouseUp, point);
        point
    end
end