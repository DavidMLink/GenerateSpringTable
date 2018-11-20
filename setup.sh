#! /bin/bash

# Grep stands for globabally search a Regular Expression then print

echo -n "Run LinkisAwesome(Yes/No): "

read response

if [ $response == "Yes" ] || [ $response == "yes" ] || [ $response == "y" ] || [ $response == "Y" ]
then
    echo "Your response was yes"
    # HAVE LINK FIGURE GENERATE
echo '                                     /@ ' 
echo '                     __        __   /\/ ' 
echo '                    /==\      /  \_/\/   ' 
echo '                  /======\    \/\__ \__' 
echo '                /==/\  /\==\    /\_|__ \ ' 
echo '             /==/    ||    \=\ / / / /_/  ' 
echo '           /=/    /\ || /\   \=\/ /  '    
echo '        /===/   /   \||/   \   \===\ ' 
echo '      /===/   ______         \   \===\ ' 
echo '   /====/   / \    /          \    \====\    THE LEGEND OF' 
echo ' /====/   /   |    | /\        \ ________  ______    _____   ____      ____' 
echo ' /==/   /     |    |/  \         |      | |       \ |     | |    |   /    / ' 
echo '|===| /       |    |____\         \    /  |        \|     | |    |  /    / ' 
echo ' \==\         |    |    /\         |  |   |         |     | |    | /    / ' 
echo ' \===\__      |    |\  /  \       /|  |   |    \          | |    |/    / ' 
echo '   \==\ \     |    |_\/____\     / |  |   |    |\         | |    /    / ' 
echo '   \===\ \    |    |             \ |  |   |    | \        | |    \    \ ' 
echo '     \==\/    |    |              \|  |   |    |  \       | |    |\    \ ' 
echo '     \==\     |    |               |  |   |    |   \      | |    | \    \ ' 
echo '       \==\  /|    |          /|  /    \  |    |    \     | |    |  \    \ ' 
echo '       \==\ / |    |_________/ | /______\ |____|     \____| |____|   \____\ ' 
echo '         \==\ /                | /==/ ' 
echo '         \=\ /_________________|/=/    SPRING VISUAL STUDIO CODE GENERATOR ' 
echo '           \==\     _____     /==/ '  
echo '            \===\   \   /   /===/ ' 
echo '           / /\===\  \_/  /===/ ' 
echo '          / / / \====\ /====/ ' 
echo '         / / /    \===|===/ ' 
echo '        / / /       \===/ ' 
echo '        |/_/          = '
echo ''
echo ''
else
    echo "Quitting..."
    sleep 1
    exit
fi



# CREATE FOLDERS

echo "Creating folders..."
mkdir models
mkdir repositories
mkdir services
mkdir controllers
sleep 2
echo ''

# END OF CREATE FOLDERS

# GLOBAL VARIABLES
echo -n "What is your GroupId(Be extremely accurate): "
read GroupId
echo -n "What is your ArtifactId(Be extremely accurate): "
read ArtifactId
echo ''



function createTable(){
    local table_name=$1
    local count=0
    # Create model file
    cd models
    touch $table_name.java
    cp fileGenesis.java $table_name.java
    sed -i "s/GROUP/$GroupId/" $table_name.java
    sed -i "s/ARTIFACT/$ArtifactId/" $table_name.java

    #Ask user for columns
    echo -n "How many columns do you want in your table(not including createdAt and updatedAt): "
    read evaluate
    echo ""
    while [ "$count" != "$evaluate" ]
    do
    #print columns one by one into file
    echo -n "What is the name of the column: "
    read column
    echo -n "What is the datatype of $column(String, Integer, Etc): "
    read datatype
    check=$(( "$evaluate - 1" ))
    if [ $count == $check ]
    then
        stringArray[count]="${datatype} ${column}"
    else
        stringArray[count]="${datatype} ${column}, "
    fi
    # concat="${datatype} ${column}, "
    # stringArray[count]+=${concat}
    datatypeArray[count]=${datatype}
    array[count]+=${column} 
    echo ""
    echo -n "Does $column have a size(Yes/No): "
    read response
    if [ $response == "Yes" ] || [ $response == "yes" ] || [ $response == "y" ] || [ $response == "Y" ]
    then
        # GENERATES SIZE
        if [ $datatype == "Integer" ]
        then
            echo -n "What is the minimum size of $column: "
            read min
            echo -n "What is the maximum size of $column: "
            read max
            echo >> $table_name.java
            echo "    @MIN($min)" >> $table_name.java
            echo "    @MAX($max)" >> $table_name.java
            echo "    private $datatype $column;" >>  $table_name.java
        else
            echo -n "What is the minimum size of $column: "
            read min
            echo -n "What is the maximum size of $column: "
            read max
            echo ""
            # echo >> $table_name.java  CREATES A NEW LINE
            echo >> $table_name.java
            echo '    @Size(min = '"$min"', max = '"$max"')' >> $table_name.java
            echo "    private $datatype $column;" >>  $table_name.java
        fi
    else
        # DOESN'T GENERATE SIZE

        echo >> $table_name.java
        echo "    private $datatype $column;" >>  $table_name.java
    fi

    # Populate Model with values
    sed -i "s/TABLENAME/$table_name/" $table_name.java
    lowercase=$(echo "$table_name" | tr "[:upper:]" "[:lower:]")
    # or
    lowercase="${table_name,,}"
    plural="${lowercase}s"
    sed -i "s/LOWERCASEPLURAL/$plural/" $table_name.java
    sed -i "s/PARAMETERSTRING/$stringArray/" $table_name.java

    echo "BEGIN OF MODEL"
    echo ''
    cat $table_name.java
    echo ""
    echo "END OF MODEL"



    echo ""
    echo ""
    # echo -n "Do you want to create another column(Yes/No): "
    # read response

    # ways to increment
    # var=$((var+1))
    # ((var=var+1))
    # ((var+=1))
    # ((var++))
    ((count++))
    length=${count}
    done
    # Automatically generate columns Created_At and Updated_At
    echo >> $table_name.java
    
    echo '    @Column(updatable=false)' >> $table_name.java
    echo '    private Date createdAt;' >> $table_name.java
    echo '    private Date updatedAt;' >> $table_name.java
    echo >> $table_name.java


    #ask user to connect table to another table
    echo -n "Do you want to connect ${table_name} table to another table(Yes/No): "
    read rel
    if [ $rel == "Yes" ] || [ $rel == "yes" ] || [ $rel == "y" ] || [ $rel == "Y" ]
    then
        echo "    //RELATIONSHIPS BETWEEN TABLES" >> $table_name.java
    fi
    while [ $rel == "Yes" ] || [ $rel == "yes" ] || [ $rel == "y" ] || [ $rel == "Y" ]
    do
        select relationship in OneToOne OneToMany ManyToMany
        do
            case $relationship in 
            OneToOne)
                ONETOONE=1
                break
                ;;
            OneToMany)
                ONETOMANY=1
                echo ""
                echo " Keep in mind that the OneToMany table that has the \"one\" MUST be the owner..."
                sleep 2
                echo ""
                break
                ;;
            ManyToMany)
                MANYTOMANY=1
                echo ""
                echo " In a Many-to-Many it does not matter which table has ownership..."
                sleep 1
                echo ""
                break
                ;;
            *)
                echo "Please provide a number between (1-3)..."
            esac
        done
        echo "Is this the Owning (1) or non-owning (2) table? (1-2)..."
        select Side in Owning non-owning
        do
            case $Side in
            Owning)
                OWNING=1
                break
                ;;
            non-owning)
                NONOWNING=1
                break
                ;;
            *)
                echo "Please provide a number between (1-2)..."
            esac
        done
        echo "What is the name of the other table you are connecting to (User, Book, Movie, etc):"
        read secondTable

        # Lowercase tablename
        lowercaseFirstTable="${table_name,,}"
        lowercaseSecondTable="${secondTable,,}"
        # Lowercase tablename

        echo "" >> $table_name.java

        if ((ONETOONE == 1))
        then
            if ((OWNING == 1))
            then
                echo "    @OneToOne(mappedBy=\"${lowercaseFirstTable}\", cascade=CascadeType.ALL, fetch=FetchType.LAZY)" >> $table_name.java
                echo "    private ${secondTable} ${lowercaseSecondTable};" >> $table_name.java
                echo "" >> $table_name.java
                echo "" >> $table_name.java
                
                echo "    public ${secondTable} get${secondTable}() {" >> $table_name.java
                echo "        return ${lowercaseSecondTable};" >> $table_name.java
                echo "    }" >> $table_name.java
                echo "" >> $table_name.java
                echo "    public void set${secondTable}(${secondTable} ${lowercaseSecondTable}) {" >> $table_name.java
                echo "        this.${lowercaseSecondTable} = ${lowercaseSecondTable};" >> $table_name.java
                echo "    }" >> $table_name.java
                echo "" >> $table_name.java
            else
                echo "    @OneToOne(fetch=FetchType.LAZY)" >> $table_name.java
                echo "    @JoinColumn(name=\"${lowercaseSecondTable}_id\")" >> $table_name.java
                echo "    private ${secondTable} ${lowercaseSecondTable};" >> $table_name.java
                echo "" >> $table_name.java
                echo "" >> $table_name.java

                echo "    public ${secondTable} get${secondTable}() {" >> $table_name.java
                echo "        return ${lowercaseSecondTable};" >> $table_name.java
                echo "    }" >> $table_name.java
                echo "" >> $table_name.java
                echo "    public void set${secondTable}(${secondTable} ${lowercaseSecondTable}) {" >> $table_name.java
                echo "        this.${lowercaseSecondTable} = ${lowercaseSecondTable};" >> $table_name.java
                echo "    }" >> $table_name.java
                echo "" >> $table_name.java
            fi
        fi
        if ((ONETOMANY == 1))
        then
            if ((OWNING == 1))
            then
                echo "    @OneToMany(mappedBy=\"${lowercaseFirstTable}\", fetch=FetchType.LAZY)" >> $table_name.java
                echo "    private List<${secondTable}> ${lowercaseSecondTable}s;" >> $table_name.java
                echo "" >> $table_name.java

                echo "    public List<${secondTable}> get${secondTable}s() {" >> $table_name.java
                echo "        return ${lowercaseSecondTable}s;" >> $table_name.java
                echo "    }" >> $table_name.java
                echo "" >> $table_name.java
                echo "    public void set${secondTable}s(List<${secondTable}> ${lowercaseSecondTable}s) {" >> $table_name.java
                echo "        this.${lowercaseSecondTable}s = ${lowercaseSecondTable}s;" >> $table_name.java
                echo "    }" >> $table_name.java
                echo "" >> $table_name.java
            else
                echo "    @ManyToOne(fetch = FetchType.LAZY)" >> $table_name.java
                echo "    @JoinColumn(name=\"${lowercaseSecondTable}_id\")" >> $table_name.java
                echo "    private ${secondTable} ${lowercaseSecondTable};" >> $table_name.java
                echo "" >> $table_name.java
                echo "    public ${secondTable} get${secondTable}() {" >> $table_name.java
                echo "        return ${lowercaseSecondTable};" >> $table_name.java
                echo "    }" >> $table_name.java
                echo "" >> $table_name.java
                echo "    public void set${secondTable}(${secondTable} ${lowercaseSecondTable}) {" >> $table_name.java
                echo "        this.${lowercaseSecondTable} = ${lowercaseSecondTable};" >> $table_name.java
                echo "    }" >> $table_name.java
                echo ""
            fi
        fi
        if (( MANYTOMANY == 1))
        then
            echo "    @ManyToMany(fetch = FetchType.LAZY)" >> $table_name.java
            echo "    @JoinTable(" >> $table_name.java
            echo "        name = \"${lowercaseFirstTable}s_${lowercaseSecondTable}s\")," >> $table_name.java
            echo "        joinColumns = @JoinColumn(name = \"${lowercaseFirstTable}_id\")," >> $table_name.java
            echo "        inverseJoinColumns = @JoinColumn(name = \"${lowercaseSecondTable}_id\"" >> $table_name.java
            echo "    )" >> $table_name.java

            echo "" >> $table_name.java
            echo "    private List<${secondTable}> ${lowercaseSecondTable}s;" >> $table_name.java
            echo "" >> $table_name.java

            echo "    public List<${secondTable}> get${secondTable}s() {" >> $table_name.java
            echo "        return ${lowercaseSecondTable}s;" >> $table_name.java
            echo "    }" >> $table_name.java
            echo "" >> $table_name.java
            echo "    public void set${secondTable}s(List<${secondTable}> ${lowercaseSecondTable}s) {" >> $table_name.java
            echo "        this.${lowercaseSecondTable}s = ${lowercaseSecondTable}s;" >> $table_name.java
            echo "    }" >> $table_name.java
            echo "" >> $table_name.java
        fi

        ONETOONE=0
        ONETOMANY=0
        MANYTOMANY=0
        NONOWNING=0
        OWNING=0
    echo -n "Do you want ${table_name} to be connected to any MORE tables(Yes/No):"
    read rel
    done

    echo "" >> $table_name.java
    echo "    //END OF RELATIONSHIPS BETWEEN TABLES" >> $table_name.java
    echo "" >> $table_name.java
    echo "" >> $table_name.java
    echo "    //GETTERS AND SETTERS" >> $table_name.java

    echo "" >> $table_name.java
    echo "    public Long getId() {" >> $table_name.java
    echo "        return id;" >> $table_name.java
    echo "    }" >> $table_name.java
    echo "    public void setId(Long id) {" >> $table_name.java
    echo "        this.id = id;" >> $table_name.java
    echo "    }" >> $table_name.java

    for ((index = 0; index < ${length}; index++))
    do
        echo "    public ${datatypeArray[index]} get${array[index]^}() {" >> $table_name.java
        echo "        return ${array[index],,};" >> $table_name.java
        echo "    }" >> $table_name.java
        echo "    public void set${array[index]^}(${datatypeArray[index]} ${array[index]})" { >> $table_name.java
        echo "        this.${array[index],,} = ${array[index],,};" >> $table_name.java
        echo "}" >> $table_name.java
    done

    echo "" >> $table_name.java
    echo "    //END OF GETTERS AND SETTERS" >> $table_name.java
    echo "" >> $table_name.java
    echo "" >> $table_name.java

    # Generate End of Table
    # cat fileOmega.java >> $table_name.java
    # or
    modelOmega $table_name

    # Populate Model with values
    sed -i "s/TABLENAME/$table_name/" $table_name.java
    lowercase=$(echo "$table_name" | tr "[:upper:]" "[:lower:]")
    # or
    lowercase="${table_name,,}"
    plural="${lowercase}s"
    sed -i "s/LOWERCASEPLURAL/$plural/" $table_name.java
    sed -i "s/PARAMETERSTRING/$stringArray/" $table_name.java
}

# CREATES BEGINNING AND END OF MODEL FILE WITHOUT THE USE OF EXTERNAL FILES
function modelGenesis(){
    echo "poop"
}

function modelOmega(){
    echo '    // CONSTRUCTORS '  >> $table_name.java
    echo '    public TABLENAME() { ' >> $table_name.java
    echo '    } ' >> $table_name.java
    echo ''
    echo '    // creates object ' >> $table_name.java
    echo -n '    public TABLENAME(' >> $table_name.java
    for items in "${stringArray[@]}"
    do
        echo -n "${items} " >> $table_name.java
    done
    echo '){ ' >> $table_name.java
    for items in ${array[@]}
    do
        echo "        this.${items} = ${items}; " >> $table_name.java
    done
    echo '    } ' >> $table_name.java
    echo '' >> $table_name.java
    echo '    // updates object' >> $table_name.java
     echo -n '    public TABLENAME(Long id, ' >> $table_name.java
    for items in ${stringArray[@]}
    do
        echo -n "${items} " >> $table_name.java
    done
    echo '){ ' >> $table_name.java
        echo '        this.id = id; ' >> $table_name.java
    for items in ${array[@]}
    do
        echo "        this.${items} = ${items}; " >> $table_name.java
    done
    echo '    } ' >> $table_name.java
    echo '' >> $table_name.java



    echo '    //END OF CONSTRUCTORS ' >> $table_name.java
    echo '' >> $table_name.java
    echo '    @PrePersist ' >> $table_name.java
    echo '    protected void onCreate(){ ' >> $table_name.java
    echo '        this.createdAt = new Date(); ' >> $table_name.java
    echo '    } ' >> $table_name.java
    echo '    @PreUpdate ' >> $table_name.java
    echo '    protected void onUpdate(){ ' >> $table_name.java
    echo '        this.updatedAt = new Date(); ' >> $table_name.java
    echo '    } ' >> $table_name.java
    echo '} ' >> $table_name.java
}

function generateRepository(){
    local table_name=$1

    cd ..
    cd repositories
    touch "${table_name}Repository.java"
    cp repoGenerator.java "${table_name}Repository.java"

    sed -i "s/TABLENAME/${table_name}/g" "${table_name}Repository.java"
    sed -i "s/GROUP/$GroupId/g" "${table_name}Repository.java"
    sed -i "s/ARTIFACT/$ArtifactId/g" "${table_name}Repository.java"
}

function generateService(){
    local table_name=$1
    lowercase="${table_name,,}"
    cd ..
    cd services
    touch "${table_name}Service.java"
    cp serviceGenerator.java "${table_name}Service.java"
    sed -i "s/TABLENAME/${table_name}/g" "${table_name}Service.java"
    sed -i "s/LOWERCASE/$lowercase/g" "${table_name}Service.java"
    sed -i "s/GROUP/$GroupId/g" "${table_name}Service.java"
    sed -i "s/ARTIFACT/$ArtifactId/g" "${table_name}Service.java"
}

function generateAPI(){
    local table_name=$1
    lowercase="${table_name,,}"
    cd ..
    cd controllers
    touch "${table_name}CRUD.java"
    cp apiGenesis.java "${table_name}CRUD.java"
    echo "" >> ${table_name}CRUD.java
    echo -n '            public TABLENAME create(' >> ${table_name}CRUD.java
    for ((index = 0; index < ${length}; index++)) 
    do
        echo -n "@RequestParam(value=\"${array[index]}\") ${stringArray[index]}" >> ${table_name}CRUD.java
    done
    echo ') { ' >> ${table_name}CRUD.java

    echo -n '                TABLENAME LOWERCASE = new TABLENAME( ' >> ${table_name}CRUD.java
    for items in "${array[@]}"
    do
        if [ "${array[-1]}" == "${items}" ]
        then
        echo -n "${items}" >> ${table_name}CRUD.java
        else
        echo -n "${items}, " >> ${table_name}CRUD.java
        fi
    done
    echo ' ); ' >> ${table_name}CRUD.java
    echo '                return LOWERCASEService.createTABLENAME(LOWERCASE); '  >> ${table_name}CRUD.java
    echo '            } '  >> ${table_name}CRUD.java
    echo '        '  >> ${table_name}CRUD.java
    echo '        // READ ' >> ${table_name}CRUD.java
    echo '            // Specific Table '  >> ${table_name}CRUD.java
    echo '            @RequestMapping("/api/LOWERCASEs/{id}") ' >> ${table_name}CRUD.java
    echo '            public TABLENAME show(@PathVariable("id") Long id) { ' >> ${table_name}CRUD.java
    echo '                TABLENAME LOWERCASE = LOWERCASEService.findTABLENAME(id); ' >> ${table_name}CRUD.java
    echo '                return LOWERCASE; ' >> ${table_name}CRUD.java
    echo '            } ' >> ${table_name}CRUD.java
    echo '            // All Tables ' >> ${table_name}CRUD.java
    echo '            @RequestMapping("/api/LOWERCASEs") ' >> ${table_name}CRUD.java
    echo '            public List<TABLENAME> index() { ' >> ${table_name}CRUD.java
    echo '                return LOWERCASEService.allTABLENAMEs(); ' >> ${table_name}CRUD.java
    echo '            } ' >> ${table_name}CRUD.java
    echo '        ' >> ${table_name}CRUD.java
    echo '        // UPDATE ' >> ${table_name}CRUD.java
    echo '            @RequestMapping(value="/api/LOWERCASEs/{id}", method=RequestMethod.PUT) ' >> ${table_name}CRUD.java
    echo -n '            public TABLENAME update(@PathVariable("id") Long id,' >> ${table_name}CRUD.java
    for ((index = 0; index < ${length}; index++))
    do
        echo -n " @RequestParam(value=\"${array[index]}\") ${stringArray[index]}" >> ${table_name}CRUD.java
    done
    echo  ') { ' >> ${table_name}CRUD.java

    echo -n '                TABLENAME LOWERCASE = new TABLENAME(id, ' >> ${table_name}CRUD.java
    for items in "${array[@]}"
    do
        if [ "${array[-1]}" == "${items}" ]
        then
        echo -n "${items}" >> ${table_name}CRUD.java
        else
        echo -n "${items}, " >> ${table_name}CRUD.java
        fi
    done
    echo ' ); ' >> ${table_name}CRUD.java
    echo '                TABLENAME LOWERCASEUpdated = LOWERCASEService.updateTABLENAME(LOWERCASE); ' >> ${table_name}CRUD.java
    echo '                return LOWERCASEUpdated; ' >> ${table_name}CRUD.java
    echo '            } ' >> ${table_name}CRUD.java
    echo '        // DELETE ' >> ${table_name}CRUD.java
    echo '            @RequestMapping(value="/api/LOWERCASEs/{id}", method=RequestMethod.DELETE) ' >> ${table_name}CRUD.java
    echo '            public void destroy(@PathVariable("id") Long id) { ' >> ${table_name}CRUD.java
    echo '                LOWERCASEService.deleteTABLENAME(id); ' >> ${table_name}CRUD.java
    echo '            } ' >> ${table_name}CRUD.java
    echo '    // END OF CRUD ' >> ${table_name}CRUD.java
    echo '} ' >> ${table_name}CRUD.java

    sed -i "s/TABLENAME/${table_name}/g" "${table_name}CRUD.java"
    sed -i "s/LOWERCASE/${lowercase}/g" "${table_name}CRUD.java"
    sed -i "s/GROUP/$GroupId/g" "${table_name}CRUD.java"
    sed -i "s/ARTIFACT/$ArtifactId/g" "${table_name}CRUD.java"
}

generateController(){
    local table_name=$1
    lowercase="${table_name,,}"
    touch "${table_name}Controller.java"
    cp controllerFrame.java "${table_name}Controller.java"
    sed -i "s/TABLENAME/${table_name}/g" "${table_name}Controller.java"
    sed -i "s/LOWERCASE/${lowercase}/g" "${table_name}Controller.java"
    sed -i "s/GROUP/$GroupId/g" "${table_name}Controller.java"
    sed -i "s/ARTIFACT/$ArtifactId/g" "${table_name}Controller.java"
}

# CREATES EVERYTHING
# CREATES EVERYTHING
# CREATES EVERYTHING

echo -n "Do you want to create any tables (Yes/No): "
read response
echo ''
while [ $response == "Yes" ] || [ $response == "yes" ] || [ $response == "y" ] || [ $response == "Y" ]
do
    array=()
    stringArray=()
    length=0
    ONETOONE=0
    ONETOMANY=0
    MANYTOMANY=0
    NONOWNING=0
    OWNING=0
    # MODEL
    echo -n "What is the name of the table(User, Book, Etc): "
    read table_name
    echo ""
    createTable $table_name
    # END OF MODEL


    # REPOSITORY
    generateRepository $table_name $GroupId $ArtifactId
    echo "Generating repository..."
    sleep 2
    echo '\\\\\_____________________\"-._ '
    echo '/////~~~~~~~~~~~~~~~~~~~~~/.-" '
    echo ""
    echo "GENERATED REPOSITORY!"
    echo ""
    # END OF REPOSITORY


    # SERVICE
    generateService $table_name $GroupId $ArtifactId
    echo "Generating service..."
    sleep 2
    echo '\\\\\_____________________\"-._ '
    echo '/////~~~~~~~~~~~~~~~~~~~~~/.-" '
    echo ""
    echo "GENERATED SERVICE!"
    echo ""
    # END OF SERVICE


    # CONTROLLER
    generateAPI $table_name $GroupId $ArtifactId $array $stringArray $length
    generateController $table_name $GroupId $ArtifactId
    echo "Generating controller..."
    sleep 2
    echo '\\\\\_____________________\"-._ '
    echo '/////~~~~~~~~~~~~~~~~~~~~~/.-" '
    echo ""
    echo "GENERATED CONTROLLER"
    echo ""
    # END OF CONTROLLER


    echo -n "Do you want to create any more tables(Yes/No): "
    read response
    cd ..
done

# END OF CREATES EVERYTHING
# END OF CREATES EVERYTHING
# END OF CREATES EVERYTHING

cd models
rm fileGenesis.java
rm fileOmega.java
cd ..
cd repositories
rm repoGenerator.java
cd ..
cd services
rm serviceGenerator.java
cd ..
cd controllers
rm controllerFrame.java
rm apiGenesis.java


# echo ""
# echo ""
# for i in 1 2 3
# do 
# echo -n '  /|\ 
#  | | | 
#   \|/ '
# echo ""
# done

echo ""
echo '                                                           : '
echo '                                                          :: '
echo '                                                         :: '
echo '                                                         :: '
echo '                                                        :: '
echo '                                                        :: '
echo '                                          __           :: '
echo '               _..-''/-¯¯--/_          ,.--. ''.     |`\=,..  '
echo '            -:--.---''-..  /_         |\\_\..  \    `-.=._/ '
echo '            .-|¯         ''.  \         \_ \-`/\ |    ::` '
echo '              /  @  \      \  -_   _..--|-\¯¯``---.-/_\ '
echo '              |   .-|      \  \\-''\_/     ¯/-.|-.\_\_/ '
echo '              \_./` /        \_//-''/    .-' 
echo '                   |           ''-/@====/              _.--.'
echo '               __.''             /¯¯ -. \-.          _/   /¯' 
echo '            .''____|   /       |''--\__\/-._       .''    | '
echo '             \ \_. \  |       _| -/        \-.____/     / '
echo '              \___\ \/  _.  (''-..| /       _      _.' 
echo '                    /  /     ¯¯¯¯ /        | ``----' 
echo '                   (  / ¯```¯¯¯¯¯|-|        | '
echo '                    \ \_.         \ \      /   '
echo '                     \___\         \ \    /  '
echo '                                     /    | '
echo '                                    /   .''  '
echo '                                   /  .  \  '
echo '                                 ./  / \  \  '
echo '                                /___/ /___|  '
# sed

echo "Happy coding!"

read stopProgram

exit
# END OF CREATE MODELS