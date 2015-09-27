#ifndef IG_ABDATA_ABELEM_AS
#define IG_ABDATA_ABELEM_AS

#include "mod_pvalptr.as"
#include "mod_opCompare.as"

#module abdata_abelem mValue

#define vartype_double 3
#define vartype_int 4

#define global abelem_new(%1,%2 = stt_zero@) newmod %1, abdata_abelem@, %2
#define global abelem_delete(%1)             delmod %1

//------------------------------------------------
// �\�z
//------------------------------------------------
#modinit var vSrc
	abelem_setv thismod, vSrc
	return getaptr(thismod)
	
//------------------------------------------------
// �l�̎擾 ( ���ߌ`�� )
//------------------------------------------------
#modfunc abelem_getv var dst
	dst = mValue
	return
	
//------------------------------------------------
// �Q�Ɖ� ( ���ߌ`�� )
//------------------------------------------------
#modfunc abelem_clone var dst
	dup dst, mValue
	return
	
//------------------------------------------------
// �l�̐ݒ� ( �ϐ� )
//------------------------------------------------
#modfunc abelem_setv var src
	mValue = src
	return
	
//------------------------------------------------
// �ϒ��v�f�̊g��
//------------------------------------------------
#modfunc abelem_memexpand int size
	memexpand mValue, size
	return
	
//------------------------------------------------
// �v�f�̌^���擾����
//------------------------------------------------
#modcfunc abelem_vartype
	return vartype(mValue)
	
//------------------------------------------------
// �v�f�̌^��ϊ�����
// 
// @+ ���̌^�� vt �������Ȃ�ϊ����Ȃ��B
//------------------------------------------------
#modfunc abelem_changeVartype int vt
	if ( vartype(mValue) != vt ) {
		dimtype mValue, vt
	}
	return
	
//------------------------------------------------
// ��r
//
// @result: ��r�l { -1 (<), 0 (==), +1 (>) }
//------------------------------------------------
#modcfunc abelem_cmp var rhs,  local lhs_ref, local rhs_ref
	abelem_clone thismod, lhs_ref
	abelem_clone rhs,     rhs_ref
	return compare(lhs_ref, rhs_ref)
	
#defcfunc compare@abdata_abelem var lhs, var rhs,  \
	local vtype, local value
	
	vtype = vartype(lhs), vartype(rhs)
	if ( (vtype(0) == vartype_double || vtype(0) == vartype_int) && (vtype(1) == vartype_double || vtype(1) == vartype_int) ) {
		value = double(lhs) - rhs
		if ( absf(value) < 1e-9 ) { return 0 }
		return int(value / absf(value))
	} else : if ( vtype(0) != vtype(1) ) {
		return vtype(0) - vtype(1)
	} else {
		return lhs != rhs
	}
#global

#endif
