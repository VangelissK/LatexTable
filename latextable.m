function latextable(decimal,labels,varargin)
    %latextable(decimal,labels,columns)
    %
    %First Argument must always be the number of decimal places, which is the same for all values of the table
    %
    %Second Argument is the column labels. Needs to be in string form, not character. For no labels, use any number, do not leave empty
    %
    %Following arguments can be any combination of column or row vectors provided they have the same length
    %
    %Table Data can only be numbers or strings. No characters
    %
    %Contact info: Vangelis Katralis, vkatralis@gmail.com, https://github.com/VangelissK , https://gitlab.com/VangelisK
    nvar=nargin-max(size(varargin));
    ncolumns=nargin-nvar;
    nrows=max(size(varargin{1}));
    if (not(isa(labels,'double')))
        if (ischar(labels))
            error('Labels cannot be a character array. Reminder: Use " " for strings')
        end
        nlabel=size(labels);
        if (max(size(labels))~=ncolumns)
            error('Labels do not match')
        end
        if (nlabel(1)~=1 && nlabel(2)~=1)
            error('Labels cannot be a matrix')
        end
    end
    if (ncolumns<=0) 
        error('No data provided')
    end
    for i=1:(ncolumns-1)
        nnc=size(varargin{i});
        nnn=size(varargin{i+1});
        if (ischar(varargin{i}))
            error('Table data can only be numbers or strings. Reminder: Use " " for strings')
        end
        if (max(nnc)~=max(nnn))
            error('Data vector sizes do not match')
        end
        if (nnc(1)~=1 && nnc(2)~=1)
            error('Arguments cannot be matrices')
        end
    end
    clear nnn
    clear nnc
    clear nlabel
    
    fprintf('%% If you want the table to span multiple pages replace "tabularx" with "xltabular" in every instance \n');
    fprintf('%% This function outputs code for the "tabularx" package. Import it using \\usepackage{tabularx}\n');
    fprintf('%% Optional: Add \\renewcommand\\tabularxcolumn[1]{m{#1}} before document start for vertically centered cells \n');
    fprintf('%% Table width can be changed by changing the \\textwidth argument in tabularx \n');
    fprintf('\\begin{table}[ht]\n');
    fprintf('\\centering\n');
    fprintf('\\begin{tabularx}{\\textwidth}{\n');
    for i=1:ncolumns
        fprintf('| > \n');
        fprintf('{\\centering\\arraybackslash}X \n');
    end
    fprintf('|}\n');
    fprintf('\\hline\n');
    if (isa(labels,'string'))
        for i=1:(ncolumns-1)
            fprintf('%s & ',labels(i))
        end
        fprintf(' %s \\\\ \n',labels(ncolumns))
        fprintf('\\hline \n');
    end
    for i=1:nrows
        for j=1:(ncolumns-1)
            if (isstring(varargin{j})) 
                fprintf('%s & ',varargin{j}(i));
            else
                fprintf('$%.*f$ & ',decimal,round(varargin{j}(i),decimal));
            end 
        end
        if (isstring(varargin{ncolumns}))
            fprintf(' %s \\\\ \n',varargin{ncolumns}(i))
        else
            fprintf('$%.*f$ \\\\ \n',decimal,round(varargin{ncolumns}(i),decimal));
        end
        fprintf('\\hline \n');
    end
    fprintf('\\end{tabularx}\n');
    fprintf('%%Optional: Captions and labels for references-------\n');
    fprintf('\\caption{}\n');
    fprintf('\\label{}\n');
    fprintf('%%---------------------------------------------------\n');
    fprintf('\\end{table}\n');
end
