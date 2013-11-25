classdef mxmlattributes
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        divisions = 768;
        key = mxmlkey;
        time = mxmltime;
        clef = [];
    end
    
    methods
        function obj = mxmlattributes(varargin)
            % time, divisions, clef, key
            switch(length(varargin))
                case 1
                    obj.time = varargin{1};
                case 2
                    obj.time = varargin{1};
                    obj.divisions = varargin{2};
                case 3
                    obj.time = varargin{1};
                    obj.divisions = varargin{2};
                    obj.clef = varargin{3};
                case 4
                    obj.time = varargin{1};
                    obj.divisions = varargin{2};
                    obj.clef = varargin{3};
                    obj.key = varargin{4};
            end
        end
        
        % Getters
        % Setters
    end
    
end

