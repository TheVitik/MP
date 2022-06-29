program Task1;
uses crt;
label ReadLine, SplitWord, StopWord,SkipAdding, CheckArray, OuterWordSort, InnerWordSort, OuterCounterSort, InnerCounterSort, Print;
var
    f : Text;
    word_,tempWord : String;
    letter : char;
    i,j,len,pos,tempCount,MAX,stoplen : Integer;
    words : Array[0..9999] of String;
    counters : Array[0..9999] of Integer;
    stopWords : Array[0..11] of String = ('the','of','a','not','for','an','I','am','m','to','on','in');
    found : boolean;
begin
    clrscr;
    assign(f,'C:\Users\lokpl\Documents\data.txt');
    reset(f);

    {SET MAX COUNT OF OUTPUT WORDS}
    MAX:=8;

    stoplen:=12;
    len:=0;
    found:=False;
    ReadLine:
    {if not end of file}
    if not EOF(f) then
        begin
        SplitWord:
        read(f,letter);
        {if not end of line, reading letter by letter}
        if (letter<>Chr(10)) and (letter<>Chr(26)) then
            begin
            {if letter in range a-Z, except 91-96 ascii code characters}
            if ((letter>='A') and (letter<='Z')) or ((letter>='a') and (letter<='z')) then
                begin
                {Uppercase to lowercase}
                if ((letter>='A') and (letter<='Z')) then
                    begin
                        letter:=Chr(ord(letter)+32);
                    end;  
                {then add letter to the current word}
                word_:=word_+letter;
                end
            else
                begin
                i:=0;
                {Check for stop word}
                StopWord:
                if i<stoplen then
                    begin
                    if stopWords[i]=word_ then
                        begin
                        goto SkipAdding;
                        end;
                    i:=i+1; 
                    goto StopWord;   
                    end;
                {Iterate array with words}
                i:=0;
                pos:=0;
                CheckArray:
                if i<len then
                    begin
                    {If word exists in words}
                    if words[i]=word_ then
                        begin
                            found:=True;
                            pos:=i;
                        end;    
                    i:=i+1;
                    goto CheckArray;
                    end;
                {If word exists, icrease the counter}
                if found then
                    begin
                    counters[pos]:=counters[pos]+1;
                    end
                else
                    {Else add a word to words list, set counter to 1}
                    begin
                    if word_<>'' then
                        begin
                        words[len]:=word_;
                        counters[len]:=1;
                        len:=len+1;
                        end;
                    end;   
                SkipAdding:
                found:=False;        
                word_:='';
                end;
            goto SplitWord;
        end
        else
            begin
            goto ReadLine;
            end;
    end;
    close(f);
    {Bubble sort}
    {Sorting by words}
    i:=0;
    j:=0;
    OuterWordSort:
    if i<len then
        begin
        j:=0;
        InnerWordSort:
        if j<len-i-1 then
            begin
            if words[j]>words[j+1] then
                begin
                {Swap numbers}
                tempCount:=counters[j];
                tempWord:=words[j];
                counters[j]:=counters[j+1];
                words[j]:=words[j+1];
                counters[j+1]:=tempCount;
                words[j+1]:=tempWord;
                end;
            j:=j+1;    
            goto InnerWordSort;
            end;
        i:=i+1;    
        goto OuterWordSort;
        end;
    {Bubble sort, descending}
    {Sorting by counter}
    i:=0;
    j:=0;
    OuterCounterSort:
    if i<len then
        begin
        j:=0;
        InnerCounterSort:
        if j<len-i-1 then
            begin
            
            if counters[j]<counters[j+1] then
                begin
                {Swap numbers}
                tempCount:=counters[j];
                tempWord:=words[j];
                counters[j]:=counters[j+1];
                words[j]:=words[j+1];
                counters[j+1]:=tempCount;
                words[j+1]:=tempWord;
                end;
            j:=j+1;    
            goto InnerCounterSort;
            end;
        i:=i+1;    
        goto OuterCounterSort;
        end;
    {Print the words and count}
    i:=0;
    Print:
    if (i<len) and (i<MAX) then
        begin
        write(words[i]+' - ');
        writeln(counters[i]);
        i:=i+1;
        goto Print;
        end;
    
    readln;
end.
