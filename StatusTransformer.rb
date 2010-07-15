# StatusTransformer.rb
# fb-clicker
#
# Created by Juan Germán Castañeda Echevarría on 7/15/10.
# Copyright 2010 UNAM. All rights reserved.

class StatusTransformer < NSValueTransformer

    def self.transformedValueClass
        return NSString
    end

    def self.allowsReverseTransformation
        return false
    end
    
    def transformedValue(value)
        value ? "Enabled" : "Disabled"
    end

end