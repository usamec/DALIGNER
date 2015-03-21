extern "C" {
  #include "align.h"
}

#include <cstdio>
#include <cstring>

char *TranslateSeq(char* x) {
  int l = strlen(x);
  char *ret = new char[l+2];
  ret[0] = 4;
  for (int i = 0; i < l; i++) {
    if (x[i] == 'A') ret[i+1] = 0;
    if (x[i] == 'C') ret[i+1] = 1;
    if (x[i] == 'G') ret[i+1] = 2;
    if (x[i] == 'T') ret[i+1] = 3;
  }
  ret[l+1] = 4;
  return ret+1;
}

int main() {
  Work_Data *work_data = New_Work_Data();
  float freq[] = {0.25, 0.25, 0.25, 0.25};
  // Tuna sa treba pozriet na parametre
  Align_Spec *align_spec = New_Align_Spec(0.7, 2, freq);

  char seq1[] = "AAACCCTTTGGGAAAC";
  char seq2[] = "AAACCCTGTGGGAAAC";

  Alignment al;
  Path p;
  al.path = &p;
  al.flags = 0;
  al.aseq = TranslateSeq(seq1);
  al.bseq = TranslateSeq(seq2);
  al.alen = 16;
  al.blen = 16;

  printf("go al\n");
  // (2,2, 4) su suradnice
  Local_Alignment(&al, work_data, align_spec, 2, 2, 4); 
  
  FILE *ca = fopen("cartoon.dat", "w");
  printf("cartoon\n");
  Alignment_Cartoon(ca, &al, 2, 4);
  FILE *aa = fopen("alignment.dat", "w");
  printf("trace\n");
  Compute_Trace_MID(&al, work_data, 2);
  printf("print al\n");
  // Zisti ako toto presne funguje
  Print_Alignment(aa, &al, work_data, 2, 80, 5, 1, 1); 
}
