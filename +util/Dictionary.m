%

% Copyright (c) 2022 Danish Belal
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without modification,
% are permitted provided that the following conditions are met:
%
% 1. Redistributions of source code must retain the above copyright notice, this
%    list of conditions and the following disclaimer.
% 2. Redistributions in binary form must reproduce the above copyright notice,
%    this list of conditions and the following disclaimer in the documentation
%    and/or other materials provided with the distribution.
% 3. Neither the name of the copyright holder nor the names of its contributors
%    may be used to endorse or promote products derived from this software without
%    specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
% ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
% IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
% INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
% NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
% PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
% WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.

classdef Dictionary < handle
properties (SetAccess = private)
    Dict Simulink.data.Dictionary = Simulink.data.Dictionary.empty
    Section Simulink.data.dictionary.Section = Simulink.data.dictionary.Section.empty
end
methods
    function this = Dictionary(DictionaryFilename, Section)
        arguments
            DictionaryFilename (1,1) string
            Section (1,1) string = "Design Data"
        end
        this.Dict = Simulink.data.dictionary.open(DictionaryFilename);
        this.Section = this.Dict.getSection(Section);
    end

    function AllEntries = Entries(this)
        AllEntries = this.Section.find();
    end

    function Entry = ByName(this, EntryName)
        arguments
            this
            EntryName (1,1) string
        end
        Entry = this.Entries();
        Entry = util.Filter(Entry, @(e) e.Name == EntryName);
        
        if class(Entry.getValue()) == "Simulink.Parameter"
            Setter = @(v) Entry.setValue(Simulink.Parameter(v));
            Getter = @()  Entry.getValue().Value;
        else
            Setter = @(v) Entry.setValue(v);
            Getter = @()  Entry.getValue();
        end
        Entry = util.AccessWrapper(Setter, Getter);
    end

    function Entries = ByType(this, Type)
        arguments
            this
            Type (1,1) string
        end
        Entries = this.Entries();
        Entries = util.Filter(Entries, @(e) class(e.getValue()) == Type);
    end

    function Result = evalin(this, Expression)
        Result = evalin(this.Section, Expression);
    end
end
end