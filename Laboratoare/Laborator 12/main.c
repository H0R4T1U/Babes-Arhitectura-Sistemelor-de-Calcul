#include <stdio.h>
#include <string.h>
void interclasare(char* a, char* b,char* sir_intercalat);
int main() {

	char sir_1[100];
	char sir_2[100];
	char sir_intercalat_1[200];
	char sir_intercalat_2[200];
	int len = 0;
	int len2 = 0;
	int i = 0;

	gets(sir_1);
	gets(sir_2);
	while (sir_1[i] != '\0') {
		len++;
		i++;
	}
	len++;
	i = 0;
	while (sir_2[i] != '\0') {
		len2++;
		i++;
	}
	len2++;
	if (len != len2) {
		printf("Sirurile nu sunt egale!");
	}
	else {
		char length[10];
		char format[15];
		sprintf(length, "%ds ", len);
		strcpy(format, "%%");
		strcat(format, length);

		interclasare(sir_1, sir_2, sir_intercalat_1);
		printf(sir_intercalat_1,format);
		interclasare(sir_2, sir_1, sir_intercalat_2);
		printf(sir_intercalat_2, format);
	}
	
	
	return 0;
}