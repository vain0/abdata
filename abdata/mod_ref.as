#ifndef IG_MODULE_REFERENCE_AS
#define IG_MODULE_REFERENCE_AS

#module

#ifndef _cat
 #define global ctype _cat(%1,%2)%1%2//
#endif

/*
* �֐��`���� dup
*
* @param index : ���̂܂ܕԒl�ƂȂ�
//*/
#defcfunc ref_dup_ctype array med, var target, int index
	dup med, target
	return index
	
/*
* �ϐ��Q�Ǝ��̃e���v���[�g
*
* @param p1:
*	�֐��`���}�N���B��2�p�����[�^�ɔ}��ϐ����n�����B
*	���̕ϐ��������̎Q�Ƃɂ��� 0 ��Ԃ��֐��ɓW�J�����ׂ��B
* @param p2...(n��):
*	p1 ���󂯎��������̌��B
//*/
#define global ctype ref_ref_expr_template_0(%1) \
	%t__ref  _cat(%i,@__ref)( %1(_cat(%o,@__ref)) )

#define global ctype ref_ref_expr_template_1(%1, %2 = _empty) \
	%t__ref   _cat(%i,@__ref)( %1(%2,_cat(%o,@__ref)) )
#define global ctype ref_ref_expr_template_2(%1, %2 = _empty, %3 = _empty) \
	%t__ref   _cat(%i,@__ref)( %1(%2,_cat(%o,@__ref),%3) )
#define global ctype ref_ref_expr_template_3(%1, %2 = _empty, %3 = _empty, %4 = _empty) \
	%t__ref   _cat(%i,@__ref)( %1(%2,_cat(%o,@__ref),%3,%4) )
#define global ctype ref_ref_expr_template_4(%1, %2 = _empty, %3 = _empty, %4 = _empty, %5 = _empty) \
	%t__ref   _cat(%i,@__ref)( %1(%2,_cat(%o,@__ref),%3,%4,%5) )

/*
* ������ւ̎Q�Ƃ����֐�
//*/
#define global ctype ref_xs(%1) \
	ref_ref_expr_template_1(ref_xs_@__ref, %1)

#defcfunc ref_xs_@__ref str value, array ref_med
	ref_med = value
	return 0
	
/*
* �����l�ւ̎Q�Ƃ����֐�
//*/
#define global ctype ref_xd(%1) \
	ref_ref_expr_template_1(ref_xd_@__ref, %1)
	
#defcfunc ref_xd_@__ref double value, array ref_med
	ref_med = value
	return 0
	
/*
* �����l�ւ̎Q�Ƃ����֐�
//*/
#define global ctype ref_xi(%1) \
	ref_ref_expr_template_1(ref_xi_@__ref, %1)

#defcfunc ref_xi_@__ref int value, array ref_med
	ref_med = value
	return 0
	
#global

#endif