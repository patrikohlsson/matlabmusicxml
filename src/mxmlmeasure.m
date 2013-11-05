classdef mxmlmeasure
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        measurenumber;
        attributes;
        tempo;
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
            [obj.pnotes, obj.poverflow] = parsenotes(notes);
            switch(length(varargin))
                case 1
                    obj.attributes = varargin{1};
                    obj.tempo = mxmltempo;
                case 2
                    if(isempty(varargin{1}))
                        obj.attributes = mxmlattributes;
                    else
                        obj.attributes = varargin{1};
                    end
                    obj.tempo = varargin{2};
                otherwise
                    obj.attributes = mxmlattributes;
                    obj.tempo = mxmltempo;
            end
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
        
        function val = get.tempo(obj)
            val = obj.tempo;
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
        function notes = parsenotes(notes)
            % TODO
        end
    end
    
end

