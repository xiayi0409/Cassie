#pragma once
#include<cstring>
using namespace std;
class student {
    public:
        student(const int Grade = 0) {};
        ~student() {}
        char* getName()
        {
            return name;
        }

        char* getTelephone()
        {
            return telephone;
        }

        char* getStudentId()
        {
            return studentID;
        }

        char* getBirthDate()
        {
            return birthDate;
        }

        char* getBirthPlace()
        {
            return birthPlace;
        }

        char* getSex()
        {
            return sex;
        }

        int& getmathGrade()
        {
            return mathgrade;
        }

        int& getchineseGrade()
        {
            return chinesegrade;
        }

        int& getenglishGrade()
        {
            return englishgrade;
        }

        void setName(char *xname)
        {
            strcpy(name, xname);
        }

        void setTelephone(char *xtelephone)
        {
            strcpy(telephone, xtelephone);
        }

        void setStudentId(char *xstudentID)
        {
            strcpy(studentID, xstudentID);
        }

        void setBirthDate(char *xbirthDate)
        {
            strcpy(birthDate, xbirthDate);
        }

        void setBirthPlace(char *xbirthPlace)
        {
            strcpy(birthPlace, xbirthPlace);
        }

        void setSex(char *xSex)
        {
            strcpy(sex, xSex);
        }

        void setmathGrade(int xmathgrade)
        {
            mathgrade = xmathgrade;
        }

        void setchineseGrade(int xchinesegrade)
        {
            chinesegrade = xchinesegrade;
        }

        void setenglishGrade(int xenglishgrade)
        {
                englishgrade = xenglishgrade;
        }

        //‘ÀÀ„∑˚÷ÿ‘ÿ
    friend bool operator<(const student& s1, const student& s2);
    friend bool operator>(const student& s1, const student& s2);
    friend bool operator<=(const student& s1, const student& s2);
    friend bool operator>=(const student& s1, const student& s2);
    friend bool operator==(const student& s1, const student& s2);
    friend bool operator!=(const student& s1, const student& s2);
    const student& operator=(const student& s)
    {
        if (this != &s)
            {
                strcpy(this->name, s.name);
                strcpy(this->telephone, s.telephone);
                strcpy(this->studentID, s.studentID);
                strcpy(this->birthDate, s.birthDate);
                strcpy(this->birthPlace, s.birthPlace);
                strcpy(this->sex, s.sex);
                this->mathgrade = s.mathgrade;
                this->chinesegrade = s.chinesegrade;
                this->englishgrade = s.englishgrade;
            }
        return *this;
    }

    private:
        char name[50];
        char telephone[12];
        char studentID[20];
        char birthDate[20];
        char birthPlace[100];
        char sex[3];
        int mathgrade,chinesegrade,englishgrade;
};

bool operator<(const student& s1, const student& s2)
{
    return s1.mathgrade+s1.chinesegrade+s1.englishgrade < s2.mathgrade + s2.chinesegrade + s2.englishgrade;
}

bool operator>(const student& s1, const student& s2)
{
    return s1.mathgrade + s1.chinesegrade + s1.englishgrade < s2.mathgrade + s2.chinesegrade + s2.englishgrade;
}

bool operator<=(const student& s1, const student& s2)
{
    return s1.mathgrade + s1.chinesegrade + s1.englishgrade < s2.mathgrade + s2.chinesegrade + s2.englishgrade;
}

bool operator>=(const student& s1, const student& s2)
{
    return s1.mathgrade + s1.chinesegrade + s1.englishgrade < s2.mathgrade + s2.chinesegrade + s2.englishgrade;
}

bool operator==(const student& s1, const student& s2)
{
    return s1.mathgrade + s1.chinesegrade + s1.englishgrade < s2.mathgrade + s2.chinesegrade + s2.englishgrade;
}

bool operator!=(const student& s1, const student& s2)
{
    return s1.mathgrade + s1.chinesegrade + s1.englishgrade < s2.mathgrade + s2.chinesegrade + s2.englishgrade;
}
