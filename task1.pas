program Task1;
uses crt;
label ReadLine, SplitWord, CheckArray, OuterSort, InnerSort, Print;
var
    f : Text;
    word_,tempWord : String;
    letter : char;
    i,j,len,pos,tempCount,MAX,fucking,slaves : Integer;
    words : Array[0..9999] of String;
    counters : Array[0..9999] of Integer;
    found : boolean;
begin
    clrscr;
    assign(f,'C:\Users\lokpl\Documents\data.txt');
    reset(f);

    {SET MAX COUNT OF OUTPUT WORDS}
    MAX:=5;

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
                {then add letter to the current word}
                word_:=word_+letter;
                end
            else
                begin
                {else reset word}
                i:=0;
                pos:=0;
                {Iterate array with words}
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
    {Bubble sort, descending}
    {Sorting by counter}
    i:=0;
    j:=0;
    OuterSort:
    if i<len then
        begin
        j:=0;
        InnerSort:
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
            goto InnerSort;
            end;
        i:=i+1;    
        goto OuterSort;
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