//id-201914044 Abdullah Al Masum
#include <stdio.h>
#include <stdlib.h>
#include <bits/stdc++.h>
#define lli long long int
#define endl "\n"
#define MAXX 1000000
#define MAXX_SIZE 256
#define Table_Size 101
#define mod_val 101
#define roll 44

using namespace std;

class SymbolInfo
{
public:
    string symbol;
    string type;
    int line_no;

    bool exists;
    SymbolInfo()
    {
        symbol = "";
        type = "";
        line_no = -1;
        exists = false;
    }
    SymbolInfo(string sym, string typ, int line)
    {
        symbol = sym;
        type = typ;
        line_no = line;
        exists = true;
    }
};

class SymbolTable : private SymbolInfo
{ //using inheritance to access easily show_info() & exists for output
    //why?cause there might be a chance of collision in my hash table because of this hash function
public:
    vector<SymbolInfo> hash_table; //i'm making a list of objects of class SymbolInfo
    SymbolTable()
    {
        for (int i = 0; i < Table_Size; i++)
        {
            hash_table.push_back(SymbolInfo());
        }
    }
    unsigned lli hash_tech(string name)
    {
        int mid_val = name.length() / 2;
        char mid_char = name[mid_val];
        int index_val = (int)(roll * (int)mid_char) % Table_Size;
        return index_val;
    }
    lli hash_fun(string name, string type)
    {
        lli index_val = hash_tech(name);
        lli j;
    level:
        if (hash_table[index_val].exists) //if already elements exists
        {
            //then check whether element's data is same or not then i'm excluding same symbol & same type
            if (name.compare(hash_table[index_val].symbol) == 0 && type.compare(hash_table[index_val].type) == 0)
            {
                return -1;
            }
            //here i have done close hashing-quadratic probing to reduce collision
            index_val = (lli)(index_val + sqrt(j)) % Table_Size;
            j++;
            goto level;
        }
        return index_val;
    }

    int insert(string name, string type, int line)
    {
        lli i = hash_fun(name, type); //hash fun depends on symbol name
        if (hash_table[i].exists == true)
        {
            return i;
        }
        if (hash_table[i].exists == false)
        {
            hash_table[i] = (SymbolInfo(name, type, line)); //in hash table i'm storing both data
        }
        return i;
    }

    int lookup(string name, string type = "") //here lookup function should have one parameter but my hash_fun() needs two parameter
    {
        //cout << "found at ";
        bool flag = false;
        //lli x = hash_fun(name, type);
        for (int i = 0; i < hash_table.size(); i++)
        {
            if (hash_table[i].symbol == name)
            {
                flag = true;
                //cout << i << ",";
                return i;
            }
        }
        if (flag == false)
            return -1;
    }
    int delete_data(string name, string type = "")
    {
        int x = lookup(name, type);
        if (x != -1)
        {
            hash_table[x].symbol = "";
            hash_table[x].type = "";
        }
        else
        {
            return -1;
        }
        return x;
    }
    void print()
    {
        cout << endl;
        for (int i = 0; i < Table_Size; i++)
        {
            printf("%3d----> ", i);
            //if (hash_table[i].exists)
            //{
            cout << "<" << hash_table[i].symbol << "," << hash_table[i].type << "," << hash_table[i].line_no << "> ";
            //}
            cout << endl;
        }
    }
    bool is_valid(char ch);
    int find_Index(string str);
    bool Check_Skip(char ch);
    bool find_keywords(string str, int lineNum);
    void Output_Keywords();
    bool find_function(string str, int lineNum);
    void Output_Functions();
    void find_identifier(string str, int lineNum);
    void Output_Identifiers();
    bool find_operator(string str, int lineNum);
    void Output_Operators();
};
