typedef enum{tipSabit, tipKimlik, tipIslt} nodeEnum;
typedef struct{int deger;} sabitNodeTip;
typedef struct{int i;} kimlikNodeTip;
typedef struct{int islem;int OpsSayi;struct nodeTypeTag *islenen[1];} isltNodeTip;
typedef struct nodeTypeTag{nodeEnum tip;union{sabitNodeTip sabit;kimlikNodeTip kimlik;isltNodeTip islt;};}nodeType;
extern int sym[26];
