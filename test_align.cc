extern "C" {
  #include "align.h"
}

#include <cstdio>
#include <cstring>

char *TranslateSeq(char* x) {
  int l = strlen(x);
  char *ret = new char[l+1];
  for (int i = 0; i < l; i++) {
    if (x[i] == 'A') ret[i] = 0;
    if (x[i] == 'C') ret[i] = 1;
    if (x[i] == 'G') ret[i] = 2;
    if (x[i] == 'T') ret[i] = 3;
  }
  ret[l] = 4;
  return ret;
}

int main() {
  Work_Data *work_data = New_Work_Data();
  float freq[] = {0.25, 0.25, 0.25, 0.25};
  Align_Spec *align_spec = New_Align_Spec(0.7, 1, freq);

  char seq1[] = "AAACCCTTTGGGAAA";
  char seq2[] = "AAACCCTTTGGGAAA";

  Alignment al;
  Path p;
  al.path = &p;
  al.flags = 0;
  al.aseq = TranslateSeq(seq1);
  al.bseq = TranslateSeq(seq2);
  al.alen = 15;
  al.blen = 15;

  printf("go al\n");
  Local_Alignment(&al, work_data, align_spec, 1, 1, 1); 
  
  FILE *ca = fopen("cartoon.dat", "w");
  printf("cartoon\n");
  Alignment_Cartoon(ca, &al, 2, 4);
  FILE *aa = fopen("alignment.dat", "w");
  printf("trace\n");
  Compute_Trace_MID(&al, work_data, 1);
  printf("print al\n");
  Print_Alignment(aa, &al, work_data, 2, 80, 5, 1, 1); 
}
