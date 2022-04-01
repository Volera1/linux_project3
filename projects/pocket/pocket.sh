if [ -d pocket_$1 ]
then
        echo "Уже существует пакет $1"
        exit 1
fi

mkdir pocket_$1
cd pocket_$1
apt download $1
nameOfFile=HELLO_USER_$1.txt

file=`ls`

dpkg -x $file my_$1_data

dpkg -e $file my_$1_META
echo '```' >> $nameOfFile
figlet -f slant $1
figlet -f slant $1 >> $nameOfFile
echo '```' >> $nameOfFile

apt show $1 2>/dev/null | sed 's/$/  /' | sed -E 's/(^\b.+?:) /**\1** /g'
apt show $1 2>/dev/null | sed 's/$/  /' | sed -E 's/(^\b.+?:) /**\1** /g' >> $nameOfFile

echo '```' >> $nameOfFile
tree -L 3 my_$1_data
tree -L 3 my_$1_data >> $nameOfFile
echo '```' >> $nameOfFile


if [ -e my_$1_META/preinst ]
then
	echo **PREINST**>>$nameOfFile
	echo '```' >> $nameOfFile
        cat my_$1_META/preinst>>$nameOfFile
	echo '```' >> $nameOfFile

fi
if [ -e my_$1_META/postinst ]
then
	echo **POSTNIST**>>$nameOfFile
	echo '```' >> $nameOfFile
        cat my_$1_META/postinst>>$nameOfFile
	echo '```' >> $nameOfFile
fi

if [ -e my_$1_META/prerm ]
then
        echo **PRERM**>>$nameOfFile
        echo '```' >> $nameOfFile
	cat my_$1_META/prerm>>$nameOfFile
	echo '```' >> $nameOfFile

fi
if [ -e my_$1_META/postrm ]
then
        echo **POSTRM**>>$nameOfFile
	echo '```' >> $nameOfFile
        cat my_$1_META/postrm>>$nameOfFile
	echo '```' >> $nameOfFile
fi


