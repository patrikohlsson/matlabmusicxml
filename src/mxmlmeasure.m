classdef mxmlmeasure
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        measurenumber;
        attributes;
    end
    
    properties(Dependent)
        notes;
        overflow;
    end
    
    properties(SetAccess=private, Hidden)
        pnotes;
        poverflow;  % mxmlnote
    end
    
    methods
        function obj = mxmlmeasure(measurenumber, notes, varargin)
            obj.measurenumber = measurenumber;
            
            switch(length(varargin))
                case 1
                    obj.attributes = varargin{1};
                case 2
                    if(isempty(varargin{1}))
                        obj.attributes = mxmlattributes;
                    else
                        obj.attributes = varargin{1};
                    end
                otherwise
                    obj.attributes = mxmlattributes;
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
        
        function val = get.overflow(obj)
            val = obj.poverflow;
        end
        
        % Setters
        function obj = set.measurenumber(obj, x)
            obj.measurenumber = x;
        end
        
        function obj = set.notes(obj, x)
            [obj.pnotes, obj.poverflow] = ...
                parsenotes(obj, x);
        end
        
        function obj = set.attributes(obj, x)
            obj.attributes = x;
        end
        
        % Operator overloading
        % m1 + m2 = [m1, m2]
        
        % Public functions
    end
    
    methods(Access=private)
        function [result, overflow] = parsenotes(obj, notes)
            meastime = obj.attributes.time.beattype / ...
                obj.attributes.time.beatcount;
            result = [];
            overflow = [];
            if(notes.ends(end)<=meastime)
                result = notes;
                overflow = [];
            else
                % TODO: Calculate overflow
                result = notes(notes.ends<=meastime);
                if(any(notes.starts<meastime & notes.ends>meastime))
                    split = notes(notes.starts<meastime & ...
                        notes.ends>meastime);
                    d1 = meastime - split.starts;
                    d2 = split.ends - split.starts;
                    split.notations.tied = 1;
                    split.duration = d1;
                    result = [result split];
                    split.notations.tied = 2;
                    split.duration = d2;
                    overflow = [split notes(notes.starts>=meastime)];
                end
            end
        end
    end
    
end