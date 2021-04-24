//id-201914044 Abdullah Al Masum
//incomplete - may be i will not complete it😅
#include "symbol_table.h"

void print_ch_arr(char str[])
{
    int n = strlen(str);
    for (int i = 0; i < n; i++)
    {
        cout << str[i];
    }
    cout << endl;
}
bool SymbolTable ::Check_Skip(char ch)
{
    if (ch == ')' || ch == '{' || ch == '}' || ch == ',' || ch == ':' || ch == ';' || ch == ' ')
    {
        return true;
    }
    else
        return false;
}
bool SymbolTable ::find_keywords(string str, int lineNum)
{
    vector<string> keywords{"if", "else", "for", "while", "break", "int", "char", "float", "double"};
    if (find(keywords.begin(), keywords.end(), str) != keywords.end())
    {
        SymbolTable::insert(str, "Keyword", lineNum);
        return true;
    }
    return false;
}
bool SymbolTable::find_function(string str, int lineNum)
{
    bool validity = SymbolTable::is_valid(str[0]);
    if (!validity)
        return false;
    SymbolTable::insert(str, type = "function", line_no = lineNum);
    return true;
}
bool SymbolTable::is_valid(char ch)
{
    if (ch >= 'a' && ch <= 'z')
        return true;
    else if (ch >= '0' && ch <= '9')
        return true;
    else if (ch >= 'A' && ch <= 'Z')
        return true;
    else if (ch == '_')
        return true;
    return false;
}
bool SymbolTable::find_operator(string str, int lineNum)
{
    vector<string> operators{"&&", "||", "==", "!=", "!", "=", "+=", "-=", "*=", "/=", "%=", "+", "-", "*", "/", "%"};
    if (find(operators.begin(), operators.end(), str) != operators.end())
    {
        SymbolTable::insert(str, type = "operator", line_no = lineNum);
        return true;
    }
    return false;
}
void SymbolTable::find_identifier(string str, int lineNum)
{
    SymbolTable::insert(str, "identifier", lineNum);
    return;
}
int main()
{
    SymbolTable obj;
    fstream file;
    string filename = "testy.txt";
    char ch;
    file.open(filename);
    int lineNum = 0;
    string str, inside_str;
    char *ch_arr;
    if (file.is_open())
    {
        while (file.good() && !file.eof())
        {
            lineNum++;
            getline(file, str);
            cout << str << endl;
            int quotation_count = 0;
            for (int i = 0; i < str.size(); i++)
            {
                bool skip_char = obj.Check_Skip(str[i]);
                // if (skip_char)
                // {
                //     cout << "skip char found at: " << i + 1 << endl;
                // }
                if (str[i] == '"' || quotation_count == 1)
                {
                    if (str[i] == '"' && quotation_count == 1)
                        quotation_count = 0;
                    else
                        quotation_count = 1;
                }
                else if (skip_char == true && inside_str.size() >= 1 || i == str.size())
                {
                    bool key = false, fun = false, opt = false, id = false;
                    if (inside_str.size() == 0)
                        continue;
                    else if (inside_str[inside_str.size() - 1] == '(')
                    {
                        inside_str.pop_back();
                        key = obj.find_keywords(inside_str, lineNum);
                        if (key == false)
                        {
                            fun = obj.find_function(inside_str, lineNum);
                        }
                    }
                    else if (key == false)
                    {
                        key = obj.find_keywords(inside_str, lineNum);
                        cout << "error happened at : " << lineNum << endl;
                    }
                    else
                    {
                        key = obj.find_keywords(inside_str, lineNum);
                        if (!key)
                        {
                            opt = obj.find_operator(inside_str, lineNum);
                        }
                        else if (!opt && !key)
                        {
                            obj.find_identifier(inside_str, lineNum);
                        }
                    }
                    // inside_str.clear();
                }
                else
                {
                    if (obj.is_valid(str[i]) == true && skip_char == false)
                    {
                        inside_str.push_back(str[i]);
                    }
                    else if (str[i] == '(')
                    {
                        str.insert(i + 1, ","); //check
                        inside_str.push_back(str[i]);
                    }
                    else if (skip_char == false)
                    {
                        //here also check
                        bool opt;
                        string s;
                        s.push_back(str[i]);
                        //here i'm checking: a = b + c;  or a != b + c;
                        // = , + (not the != operator)
                        bool current = obj.is_valid(str[i]);
                        bool next = obj.Check_Skip(str[i + 1]);

                        if (current == true || next == true)
                        {
                            opt = obj.find_operator(s, lineNum);
                            if (!opt)
                            {
                                cout << "error happened at : " << lineNum << endl;
                                str.insert(i + 1, ","); //check
                            }
                        }
                        else
                        {
                            //now i will check : a != b + c; != is my target
                            s.push_back(str[i + 1]);
                            opt = obj.find_operator(s, lineNum);
                            //now if : a!# b +c; target !#
                            if (!opt)
                            {
                                cout << "error happened at : " << lineNum << endl;
                                str[i + 1] = ' '; //space pushed
                            }
                        }
                    }
                }
                inside_str.clear();
            }
        }

        // strcpy(ch_arr, str.c_str());
        // print_ch_arr(ch_arr);
        // cout << "The length of line number " << lineNum << " is: " << s.length() << endl;
        // obj.find_keywords(s, lineNum);
        // obj.find_function(s);
        // obj.find_identifier(s);
        //obj.find_operator(str);
        cout << "Total Line : " << lineNum << endl;
        file.close();
        obj.print();
    }
    return 0;
}
