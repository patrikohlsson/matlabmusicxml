classdef mxmlmeasure
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        measurenumber;
        attributes;
        time;
    end
    
    properties(Dependent)
        notes;
        overflow;
    end
    
    properties(SetAccess=private, Hidden)
        pnotes;
        poverflow;
    end
    
    methods
        function obj = mxmlmeasure(measurenumber, notes, varargin)
            obj.measurenumber = measurenumber;
            
            switch(length(varargin))
                case 1
                    obj.attributes = varargin{1};
                    obj.time = mxmltime;
                case 2
                    if(isempty(varargin{1}))
                        obj.attributes = mxmlattributes;
                    else
                        obj.attributes = varargin{1};
                    end
                    obj.time = varargin{2};
                otherwise
                    obj.attributes = mxmlattributes;
                    obj.time = mxmltime;
            end
            
            [obj.pnotes, obj.poverflow] = parsenotes(obj, notes);
        end
        
        % Getters
        function val = get.measurenumber(obj)
            val = obj.measurenumber;
        end
        
        function val = get.notes(obj)
            val = obj.pnotes;
        end
        
        function val = get.attributes(obj)
            val = obj.attributes;
        end
        
        function val = get.time(obj)
            val = obj.time;
        end
        
        function val = get.overflow(obj)
            val = obj.poverflow;
        end
        
        % Setters
        function obj = set.measurenumber(obj, x)
            obj.measurenumber = x;
        end
        
        function obj = set.notes(obj, x)
            obj.pnotes = x;
            obj.poverflow = [1 2 3 4];
        end
        
        function obj = set.attributes(obj, x)
            obj.attributes = x;
        end
        
        % Operator overloading
        
        % Public functions
    end
    
    methods(Access=private)
        function [result, overflow] = parsenotes(obj, notes)
            meastime = obj.attributes.time.beattype / ...
                obj.attributes.time.beatcount;
            
            if(notes.ends(end)<=meastime)
                result = notes;
                overflow = [];
                return;
            end
            
        end
    end
    
end

