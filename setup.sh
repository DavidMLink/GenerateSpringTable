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
mkdir model
mkdir repository
mkdir service
mkdir controller
sleep 1

# END OF CREATE FOLDERS

# GLOBAL VARIABLES
echo -n "What is your GroupId(Be extremely accurate): "
read GroupId
echo -n "What is your ArtifactId(Be extremely accurate): "
read ArtifactId
array=()
stringArray=()
length=0


function createTable(){
    local table_name=$1
    local count=0
    # Create model file
    cd model
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
    echo $count
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
        echo "${stringArray[@]}"
    # concat="${datatype} ${column}, "
    # stringArray[count]+=${concat}

    array[count]+=${column} 
    echo "${array[@]}"
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
    cat $table_name.java



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
    cd repository
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
    cd service
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
    cd controller
    touch "${table_name}CRUD.java"
    cp apiGenesis.java "${table_name}CRUD.java"
    echo "" >> ${table_name}CRUD.java
    echo -n '            public TABLENAME create(' >> ${table_name}CRUD.java
    for ((index = 0; index < ${length}; index++)) 
    do
        echo -n "@RequestParam(value=${array[index]}) ${stringArray[index]}" >> ${table_name}CRUD.java
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
        echo -n " @RequestParam(value='${array[index]}') ${stringArray[index]}" >> ${table_name}CRUD.java
    done
    echo  ') { ' >> ${table_name}CRUD.java

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


# CREATES EVERYTHING
# CREATES EVERYTHING
# CREATES EVERYTHING

echo -n "Do you want to create any tables (Yes/No): "
read response
while [ $response == "Yes" ] || [ $response == "yes" ] || [ $response == "y" ] || [ $response == "Y" ]
do
    # MODEL
    echo -n "What is the name of the table(User, Book, Etc): "
    read table_name
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
done

# END OF CREATES EVERYTHING
# END OF CREATES EVERYTHING
# END OF CREATES EVERYTHING

cd models
rm fileGenesis.java
rm fileOmega.java
cd ..
cd repository
rm repoGenerator.java
cd ..
cd service
rm serviceGenerator.java
cd ..
cd controller
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

exit
# END OF CREATE MODELS