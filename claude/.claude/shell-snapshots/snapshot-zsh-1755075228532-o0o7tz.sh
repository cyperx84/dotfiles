# Snapshot file
# Unset all aliases to avoid conflicts with functions
unalias -a 2>/dev/null || true
# Functions
→chroma/-alias.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-autoload.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-autorandr.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-awk.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-docker.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-example.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-fast-theme.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-fpath_peq.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-git.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-grep.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-hub.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-ionice.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-lab.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-make.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-nice.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-nmcli.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-node.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-ogit.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-perl.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-podman.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-precommand.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-printf.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-ruby.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-scp.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-sh.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-source.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-ssh.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-subcommand.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-subversion.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-vim.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-whatis.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-which.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-zinit.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/main-chroma.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-alias.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-autoload.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-autorandr.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-awk.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-docker.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-example.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-fast-theme.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-fpath_peq.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-git.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-grep.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-hub.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-ionice.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-lab.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-make.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-nice.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-nmcli.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-node.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-ogit.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-perl.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-podman.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-precommand.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-printf.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-ruby.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-scp.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-sh.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-source.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-ssh.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-subcommand.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-subversion.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-vim.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-whatis.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-which.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/-zinit.ch () {
	# undefined
	builtin autoload -XUz
}
→chroma/main-chroma.ch () {
	# undefined
	builtin autoload -XUz
}
-- () {
	# undefined
	builtin autoload -XUz
}
-fast-highlight-check-path () {
	(( _start_pos-__PBUFLEN >= 0 )) || {
		[[ $1 != "noasync" ]] && print -r -- "- $_start_pos $_end_pos"
		return 1
	}
	[[ $1 != "noasync" ]] && {
		print -r -- ${sysparams[pid]}
		print -r -- $__arg
	}
	: ${expanded_path:=${(Q)~__arg}}
	[[ -n ${FAST_BLIST_PATTERNS[(k)${${(M)expanded_path:#/*}:-$PWD/$expanded_path}]} ]] && {
		[[ $1 != "noasync" ]] && print -r -- "- $_start_pos $_end_pos"
		return 1
	}
	[[ -z $expanded_path ]] && {
		[[ $1 != "noasync" ]] && print -r -- "- $_start_pos $_end_pos"
		return 1
	}
	[[ -d $expanded_path ]] && {
		[[ $1 != "noasync" ]] && print -r -- "$_start_pos ${_end_pos}D" || __style=${FAST_THEME_NAME}path-to-dir 
		return 0
	}
	[[ -e $expanded_path ]] && {
		[[ $1 != "noasync" ]] && print -r -- "$_start_pos $_end_pos" || __style=${FAST_THEME_NAME}path 
		return 0
	}
	[[ $active_command = "cd" ]] && for cdpath_dir in $cdpath
	do
		[[ -d $cdpath_dir/$expanded_path ]] && {
			[[ $1 != "noasync" ]] && print -r -- "$_start_pos ${_end_pos}D" || __style=${FAST_THEME_NAME}path-to-dir 
			return 0
		}
		[[ -e $cdpath_dir/$expanded_path ]] && {
			[[ $1 != "noasync" ]] && print -r -- "$_start_pos $_end_pos" || __style=${FAST_THEME_NAME}path 
			return 0
		}
	done
	[[ $1 != "noasync" ]] && print -r -- "- $_start_pos $_end_pos"
	return 1
}
-fast-highlight-check-path-handler () {
	local IFS=$'\n' pid PCFD=$1 line stripped val 
	integer idx
	if read -r -u $PCFD pid
	then
		if read -r -u $PCFD val
		then
			if read -r -u $PCFD line
			then
				stripped=${${line#- }%D} 
				FAST_HIGHLIGHT[cache-path-${(q)val}-${stripped%% *}-born-at]=$EPOCHSECONDS 
				idx=${${FAST_HIGHLIGHT[path-queue]}[(I)$stripped]} 
				(( idx > 0 )) && {
					if [[ $line != -* ]]
					then
						FAST_HIGHLIGHT[cache-path-${(q)val}-${stripped%% *}]="1${(M)line%D}" 
						region_highlight+=("${line%% *} ${${line##* }%D} ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}path${${(M)line%D}:+-to-dir}]}") 
					else
						FAST_HIGHLIGHT[cache-path-${(q)val}-${stripped%% *}]=0 
					fi
					val=${FAST_HIGHLIGHT[path-queue]} 
					val[idx-1,idx+${#stripped}]="" 
					FAST_HIGHLIGHT[path-queue]=$val 
					[[ ${FAST_HIGHLIGHT[cache-path-${(q)val}-${stripped%% *}]%D} = 1 && ${#val} -le 27 ]] && zle -R
				}
			fi
		fi
		kill -9 $pid 2> /dev/null
	fi
	zle -F -w ${PCFD}
	exec {PCFD}<&-
}
-fast-highlight-dollar-string () {
	(( _start_pos-__PBUFLEN >= 0 )) || return 0
	local i j k __style
	local AA
	integer c
	for ((i = 3 ; i < _end_pos - _start_pos ; i += 1 )) do
		(( j = i + _start_pos - 1 ))
		(( k = j + 1 ))
		case ${__arg[$i]} in
			("\\") __style=${FAST_THEME_NAME}back-dollar-quoted-argument 
				for ((c = i + 1 ; c <= _end_pos - _start_pos ; c += 1 )) do
					[[ ${__arg[$c]} != ([0-9xXuUa-fA-F]) ]] && break
				done
				AA=$__arg[$i+1,$c-1] 
				if [[ "$AA" == (#m)(#s)(x|X)[0-9a-fA-F](#c1,2) || "$AA" == (#m)(#s)[0-7](#c1,3) || "$AA" == (#m)(#s)u[0-9a-fA-F](#c1,4) || "$AA" == (#m)(#s)U[0-9a-fA-F](#c1,8) ]]
				then
					(( k += MEND ))
					(( i += MEND ))
				else
					if (( __asize > i+1 )) && [[ $__arg[i+1] == [xXuU] ]]
					then
						__style=${FAST_THEME_NAME}unknown-token 
					fi
					(( k += 1 ))
					(( i += 1 ))
				fi ;;
			(*) continue ;;
		esac
		(( __start=j-__PBUFLEN, __end=k-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[$__style]}") 
	done
}
-fast-highlight-fill-option-variables () {
	if [[ -o ignore_braces ]] || eval '[[ -o ignore_close_braces ]] 2>/dev/null'
	then
		FAST_HIGHLIGHT[right_brace_is_recognised_everywhere]=0 
	else
		FAST_HIGHLIGHT[right_brace_is_recognised_everywhere]=1 
	fi
	if [[ -o path_dirs ]]
	then
		FAST_HIGHLIGHT[path_dirs_was_set]=1 
	else
		FAST_HIGHLIGHT[path_dirs_was_set]=0 
	fi
	if [[ -o multi_func_def ]]
	then
		FAST_HIGHLIGHT[multi_func_def]=1 
	else
		FAST_HIGHLIGHT[multi_func_def]=0 
	fi
	if [[ -o interactive_comments ]]
	then
		FAST_HIGHLIGHT[ointeractive_comments]=1 
	else
		FAST_HIGHLIGHT[ointeractive_comments]=0 
	fi
}
-fast-highlight-init () {
	_FAST_COMPLEX_BRACKETS=() 
	__fast_highlight_main__command_type_cache=() 
}
-fast-highlight-main-type () {
	REPLY=$__fast_highlight_main__command_type_cache[(e)$1] 
	[[ -z $REPLY ]] && {
		if zmodload -e zsh/parameter
		then
			if (( $+aliases[(e)$1] ))
			then
				REPLY=alias 
			elif (( ${+galiases[(e)${(Q)1}]} ))
			then
				REPLY="global alias" 
			elif (( $+functions[(e)$1] ))
			then
				REPLY=function 
			elif (( $+builtins[(e)$1] ))
			then
				REPLY=builtin 
			elif (( $+commands[(e)$1] ))
			then
				REPLY=command 
			elif (( $+saliases[(e)${1##*.}] ))
			then
				REPLY='suffix alias' 
			elif (( $reswords[(Ie)$1] ))
			then
				REPLY=reserved 
			elif [[ $1 != */* || ${+ZSH_ARGZERO} = "1" ]] && ! builtin type -w -- $1 > /dev/null 2>&1
			then
				REPLY=none 
			fi
		fi
		[[ -z $REPLY ]] && REPLY="${$(LC_ALL=C builtin type -w -- $1 2>/dev/null)##*: }" 
		[[ $REPLY = "none" ]] && {
			[[ -n ${FAST_BLIST_PATTERNS[(k)${${(M)1:#/*}:-$PWD/$1}]} ]] || {
				[[ -d $1 ]] && REPLY="dirpath"  || {
					for cdpath_dir in $cdpath
					do
						[[ -d $cdpath_dir/$1 ]] && {
							REPLY="dirpath" 
							break
						}
					done
				}
			}
		}
		__fast_highlight_main__command_type_cache[(e)$1]=$REPLY 
	}
}
-fast-highlight-math-string () {
	(( _start_pos-__PBUFLEN >= 0 )) || return 0
	_mybuf=$__arg 
	__idx=_start_pos 
	while [[ $_mybuf = (#b)[^\$_a-zA-Z0-9]#((\$(#B)(+|)(#B)([a-zA-Z_:][a-zA-Z0-9_:]#|[0-9]##)(#b)(\[[^\]]##\])(#c0,1))|(\$[{](#B)(+|)(#b)(\([a-zA-Z0-9_:@%#]##\))(#c0,1)[a-zA-Z0-9_:#]##(\[[^\]]##\])(#c0,1)[}])|\$|[a-zA-Z_][a-zA-Z0-9_]#|[0-9]##)(*) ]]
	do
		__idx+=${mbegin[1]}-1 
		_end_idx=__idx+${mend[1]}-${mbegin[1]}+1 
		_mybuf=${match[7]} 
		[[ ${match[1]} = [0-9]* ]] && __style=${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}mathnum]}  || {
			[[ ${match[1]} = [a-zA-Z_]* ]] && {
				[[ ${+parameters[${match[1]}]} = 1 || ${FAST_ASSIGNS_SEEN[${match[1]}]} = 1 ]] && __style=${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}mathvar]}  || __style=${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}matherr]} 
			} || {
				[[ ${match[1]} = "$"* ]] && {
					match[1]=${match[1]//[\{\}+]/} 
					if [[ ${match[1]} = "$" || ${FAST_ASSIGNS_SEEN[${match[1]:1}]} = 1 ]] || {
							eval "[[ -n \${(P)\${match[1]:1}} ]]"
						} 2>> /dev/null
					then
						__style=${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}back-or-dollar-double-quoted-argument]} 
					else
						__style=${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}matherr]} 
					fi
				}
			}
		}
		[[ $__style != "none" && -n $__style ]] && (( __start=__idx-__PBUFLEN, __end=_end_idx-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end $__style") 
		__idx=_end_idx 
	done
}
-fast-highlight-process () {
	emulate -L zsh
	setopt extendedglob bareglobqual nonomatch typesetsilent
	[[ $CONTEXT == "select" ]] && return 0
	(( FAST_HIGHLIGHT[path_dirs_was_set] )) && setopt PATH_DIRS
	(( FAST_HIGHLIGHT[ointeractive_comments] )) && local interactive_comments= 
	local _start_pos=$3 _end_pos __start __end highlight_glob=1 __arg __style in_array_assignment=0 MATCH expanded_path braces_stack __buf=$1$2 _mybuf __workbuf cdpath_dir active_command alias_target _was_double_hyphen=0 __nul=$'\0' __tmp 
	integer __arg_type=0 MBEGIN MEND in_redirection __len=${#__buf} __PBUFLEN=${#1} already_added offset __idx _end_idx this_word=1 next_word=0 __pos __asize __delimited=0 itmp iitmp 
	local -a match mbegin mend __inputs __list
	integer BIT_case_preamble=512 BIT_case_item=1024 BIT_case_nempty_item=2048 BIT_case_code=4096 
	ZLAST_COMMANDS=() 
	FAST_ASSIGNS_SEEN=() 
	FAST_HIGHLIGHT[chroma-autoload-elements]="" 
	FAST_HIGHLIGHT[chroma-fpath_peq-elements]="" 
	FAST_HIGHLIGHT[chroma-zinit-ice-elements-svn]=0 
	FAST_HIGHLIGHT[chroma-zinit-ice-elements-id-as]="" 
	[[ -n $ZCALC_ACTIVE ]] && {
		_start_pos=0 
		_end_pos=__len 
		__arg=$__buf 
		-fast-highlight-math-string
		return 0
	}
	local proc_buf=$__buf needle 
	for __arg in ${interactive_comments-${(z)__buf}} ${interactive_comments+${(zZ+c+)__buf}}
	do
		(( in_redirection = in_redirection > 0 ? in_redirection - 1 : in_redirection ))
		(( next_word = (in_redirection == 0) ? 2 : next_word ))
		(( next_word = next_word | (this_word & (BIT_case_code|8192)) ))
		[[ $__arg = '{' && $__delimited = 2 ]] && {
			(( this_word = (this_word & ~2) | 1 ))
			__delimited=0 
		}
		__asize=${#__arg} 
		already_added=0 
		__style=${FAST_THEME_NAME}unknown-token 
		(( this_word & 1 )) && {
			in_array_assignment=0 
			[[ $__arg == 'noglob' ]] && highlight_glob=0 
		}
		if [[ $__arg == ';' ]]
		then
			braces_stack=${braces_stack#T} 
			__delimited=0 
			needle=$';\n' 
			[[ $proc_buf = (#b)[^$needle]#([$needle]##)* ]] && offset=${mbegin[1]}-1 
			(( _start_pos += offset ))
			(( _end_pos = _start_pos + __asize ))
			(( this_word & BIT_case_item )) || {
				(( in_array_assignment )) && (( this_word = 2 | (this_word & BIT_case_code) )) || {
					(( this_word = 1 | (this_word & BIT_case_code) ))
					highlight_glob=1 
				}
			}
			in_redirection=0 
			[[ ${proc_buf[offset+1]} != $'\n' ]] && {
				[[ ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}commandseparator]} != "none" ]] && (( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}commandseparator]}") 
			}
			proc_buf=${proc_buf[offset + __asize + 1,__len]} 
			_start_pos=$_end_pos 
			continue
		else
			offset=0 
			if [[ $proc_buf = (#b)(#s)(([[:space:]]|\\[[:space:]])##)* ]]
			then
				offset=${mend[1]} 
			fi
			(( _start_pos += offset ))
			(( _end_pos = _start_pos + __asize ))
			__arg_type=${__FAST_HIGHLIGHT_TOKEN_TYPES[$__arg]} 
		fi
		(( this_word & 1 )) && ZLAST_COMMANDS+=($__arg) 
		proc_buf=${proc_buf[offset + __asize + 1,__len]} 
		if [[ -n ${interactive_comments+'set'} && $__arg == ${histchars[3]}* ]]
		then
			if (( this_word & 3 ))
			then
				__style=${FAST_THEME_NAME}comment 
			else
				__style=${FAST_THEME_NAME}unknown-token 
			fi
			(( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[$__style]}") 
			_start_pos=$_end_pos 
			continue
		fi
		[[ $__arg == (<0-9>|)(\<|\>)* && $__arg != (\<|\>)$'\x28'* && $__arg != "<<<" ]] && in_redirection=2 
		if (( ! in_redirection ))
		then
			(( this_word & 4 )) && [[ $__arg != -* ]] && (( this_word = this_word ^ 4 ))
			if (( this_word & 4 ))
			then
				case $__arg in
					('-'[Cgprtu]) (( this_word = this_word & ~1 ))
						(( next_word = 8 | (this_word & BIT_case_code) )) ;;
					('-'*) (( this_word = this_word & ~1 ))
						(( next_word = next_word | 1 | 4 )) ;;
				esac
			elif (( this_word & 8 ))
			then
				(( next_word = next_word | 4 | 1 ))
			elif (( this_word & 64 ))
			then
				[[ $__arg = -[pvV-]## && $active_command = "command" ]] && (( this_word = (this_word & ~1) | 2, next_word = (next_word | 65) & ~2 ))
				[[ $__arg = -[cla-]## && $active_command = "exec" ]] && (( this_word = (this_word & ~1) | 2, next_word = (next_word | 65) & ~2 ))
				[[ $__arg = \{[a-zA-Z_][a-zA-Z0-9_]#\} && $active_command = "exec" ]] && {
					(( this_word = (this_word & ~1) | 2, next_word = (next_word | 65) & ~2 ))
					(( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}exec-descriptor]}") 
					already_added=1 
				}
			fi
		fi
		(( this_word & 8192 )) && {
			__list=(${(z@)${aliases[$active_command]:-${active_command##*/}}##[[:space:]]#(command|builtin|exec|noglob|nocorrect|pkexec)[[:space:]]#}) 
			${${FAST_HIGHLIGHT[chroma-${__list[1]}]}%\%*} ${(M)FAST_HIGHLIGHT[chroma-${__list[1]}]%\%*} 0 "$__arg" $_start_pos $_end_pos 2> /dev/null && continue
		}
		(( this_word & 1 )) && {
			(( !in_redirection )) && active_command=$__arg 
			_mybuf=${${aliases[$active_command]:-${active_command##*/}}##[[:space:]]#(command|builtin|exec|noglob|nocorrect|pkexec)[[:space:]]#} 
			[[ "$_mybuf" = (#b)(FPATH+(#c0,1)=)* ]] && _mybuf="${match[1]} ${(j: :)${(s,:,)${_mybuf#FPATH+(#c0,1)=}}}" 
			[[ -n ${FAST_HIGHLIGHT[chroma-${_mybuf%% *}]} ]] && {
				__list=(${(z@)_mybuf}) 
				if (( ${#__list} > 1 )) || [[ $active_command != $_mybuf ]]
				then
					__style=${FAST_THEME_NAME}alias 
					(( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[$__style]}") 
					${${FAST_HIGHLIGHT[chroma-${__list[1]}]}%\%*} ${(M)FAST_HIGHLIGHT[chroma-${__list[1]}]%\%*} 1 "${__list[1]}" "-100000" $_end_pos 2> /dev/null || (( this_word = next_word, next_word = 2 ))
					for _mybuf in "${(@)__list[2,-1]}"
					do
						(( next_word = next_word | (this_word & (BIT_case_code|8192)) ))
						${${FAST_HIGHLIGHT[chroma-${__list[1]}]}%\%*} ${(M)FAST_HIGHLIGHT[chroma-${__list[1]}]%\%*} 0 "$_mybuf" "-100000" $_end_pos 2> /dev/null || (( this_word = next_word, next_word = 2 ))
					done
					_start_pos=$_end_pos 
					continue
				else
					${${FAST_HIGHLIGHT[chroma-${__list[1]}]}%\%*} ${(M)FAST_HIGHLIGHT[chroma-${__list[1]}]%\%*} 1 "$__arg" $_start_pos $_end_pos 2> /dev/null && continue
				fi
			} || (( 1 ))
		}
		expanded_path="" 
		if (( this_word & 16 )) && [[ $__arg == 'always' ]]
		then
			__style=${FAST_THEME_NAME}reserved-word 
			(( next_word = 1 | (this_word & BIT_case_code) ))
		elif (( (this_word & 1) && (in_redirection == 0) )) || [[ $braces_stack = T* ]]
		then
			if (( __arg_type == 1 ))
			then
				__style=${FAST_THEME_NAME}precommand 
				[[ $__arg = "command" || $__arg = "exec" ]] && (( next_word = next_word | 64 ))
			elif [[ $__arg = (sudo|doas) ]]
			then
				__style=${FAST_THEME_NAME}precommand 
				(( next_word = (next_word & ~2) | 4 | 1 ))
			else
				_mybuf=${${(Q)__arg}#\"} 
				if (( ${+parameters} )) && [[ $_mybuf = (#b)(*)(*)\$([a-zA-Z_][a-zA-Z0-9_]#|[0-9]##)(*) || $_mybuf = (#b)(*)(*)\$\{([a-zA-Z_][a-zA-Z0-9_:-]#|[0-9]##)(*) ]] && (( ${+parameters[${match[3]%%:-*}]} ))
				then
					-fast-highlight-main-type ${match[1]}${match[2]}${(P)match[3]%%:-*}${match[4]#\}}
				elif [[ $braces_stack = T* ]]
				then
					REPLY=none 
				else
					: ${expanded_path::=${~_mybuf}}
					-fast-highlight-main-type $expanded_path
				fi
				case $REPLY in
					(reserved) [[ $__arg = "[[" ]] && __style=${FAST_THEME_NAME}double-sq-bracket  || __style=${FAST_THEME_NAME}reserved-word 
						if [[ $__arg == $'\x7b' ]]
						then
							braces_stack='Y'$braces_stack 
						elif [[ $__arg == $'\x7d' && $braces_stack = Y* ]]
						then
							braces_stack=${braces_stack#Y} 
							__style=${FAST_THEME_NAME}reserved-word 
							(( next_word = next_word | 16 ))
						elif [[ $__arg == "[[" ]]
						then
							braces_stack='A'$braces_stack 
							_FAST_COMPLEX_BRACKETS+=($(( _start_pos-__PBUFLEN )) $(( _start_pos-__PBUFLEN + 1 ))) 
						elif [[ $__arg == "for" ]]
						then
							(( next_word = next_word | 32 ))
						elif [[ $__arg == "case" ]]
						then
							(( next_word = BIT_case_preamble ))
						elif [[ $__arg = (typeset|declare|local|float|integer|export|readonly) ]]
						then
							braces_stack='T'$braces_stack 
						fi ;;
					('suffix alias') __style=${FAST_THEME_NAME}suffix-alias  ;;
					('global alias') __style=${FAST_THEME_NAME}global-alias  ;;
					(alias) if [[ $__arg = ?*'='* ]]
						then
							__style=${FAST_THEME_NAME}unknown-token 
						else
							__style=${FAST_THEME_NAME}alias 
							(( ${+aliases} )) && alias_target=${aliases[$__arg]}  || alias_target="${"$(alias -- $__arg)"#*=}" 
							[[ ${__FAST_HIGHLIGHT_TOKEN_TYPES[$alias_target]} = "1" && $__arg_type != "1" ]] && __FAST_HIGHLIGHT_TOKEN_TYPES[$__arg]="1" 
						fi ;;
					(builtin) [[ $__arg = "[" ]] && {
							__style=${FAST_THEME_NAME}single-sq-bracket 
							_FAST_COMPLEX_BRACKETS+=($(( _start_pos-__PBUFLEN ))) 
						} || __style=${FAST_THEME_NAME}builtin 
						[[ $__arg = (typeset|declare|local|float|integer|export|readonly) ]] && braces_stack='T'$braces_stack 
						[[ $__arg = eval ]] && (( next_word = next_word | 256 )) ;;
					(function) __style=${FAST_THEME_NAME}function  ;;
					(command) __style=${FAST_THEME_NAME}command  ;;
					(hashed) __style=${FAST_THEME_NAME}hashed-command  ;;
					(dirpath) __style=${FAST_THEME_NAME}path-to-dir  ;;
					(none) if [[ $__arg == [a-zA-Z_][a-zA-Z0-9_]#(|\[[^\]]#\])(|[^\]]#\])(|[+])=* || $__arg == [0-9]##(|[+])=* || ( $braces_stack = T* && ${__arg_type} != 3 ) ]]
						then
							__style=${FAST_THEME_NAME}assign 
							FAST_ASSIGNS_SEEN[${__arg%%=*}]=1 
							[[ $__arg = (#b)*=(\()*(\))* || $__arg = (#b)*=(\()* ]] && {
								(( __start=_start_pos-__PBUFLEN+${mbegin[1]}-1, __end=__start+1, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}assign-array-bracket]}") 
								_FAST_COMPLEX_BRACKETS+=($__start) 
								(( mbegin[2] >= 1 )) && {
									(( __start=_start_pos-__PBUFLEN+${mbegin[2]}-1, __end=__start+1, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}assign-array-bracket]}") 
									_FAST_COMPLEX_BRACKETS+=($__start) 
								} || in_array_assignment=1 
							} || {
								[[ ${braces_stack[1]} != 'T' ]] && (( next_word = (next_word | 1) & ~2 ))
							}
							local ctmp="\"" dtmp="'" 
							itmp=${__arg[(i)$ctmp]}-1 iitmp=${__arg[(i)$dtmp]}-1 
							integer jtmp=${__arg[(b:itmp+2:i)$ctmp]} jjtmp=${__arg[(b:iitmp+2:i)$dtmp]} 
							(( itmp < iitmp && itmp <= __asize - 1 )) && (( jtmp > __asize && (jtmp = __asize), 1 > 0 )) && (( __start=_start_pos-__PBUFLEN+itmp, __end=_start_pos-__PBUFLEN+jtmp, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}double-quoted-argument]}")  && {
								itmp=${__arg[(i)=]} 
								__arg=${__arg[itmp,__asize]} 
								(( _start_pos += itmp - 1 ))
								-fast-highlight-string
								(( _start_pos = _start_pos - itmp + 1, 1 > 0 ))
							} || {
								(( iitmp <= __asize - 1 )) && (( jjtmp > __asize && (jjtmp = __asize), 1 > 0 )) && (( __start=_start_pos-__PBUFLEN+iitmp, __end=_start_pos-__PBUFLEN+jjtmp, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}single-quoted-argument]}") 
							} || {
								itmp=${__arg[(i)=]} 
								__arg=${__arg[itmp,__asize]} 
								(( _start_pos += itmp - 1 ))
								[[ ${__arg[2,4]} = '$((' ]] && {
									-fast-highlight-math-string
									(( __start=_start_pos-__PBUFLEN+2, __end=__start+2, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}double-paren]}") 
									_FAST_COMPLEX_BRACKETS+=($__start $(( __start + 1 ))) 
									(( jtmp = ${__arg[(I)\)\)]}-1, jtmp > 0 )) && {
										(( __start=_start_pos-__PBUFLEN+jtmp, __end=__start+2, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}double-paren]}") 
										_FAST_COMPLEX_BRACKETS+=($__start $(( __start + 1 ))) 
									}
								} || -fast-highlight-string
								(( _start_pos = _start_pos - itmp + 1, 1 > 0 ))
							}
						elif [[ $__arg = ${histchars[1]}* && -n ${__arg[2]} ]]
						then
							__style=${FAST_THEME_NAME}history-expansion 
						elif [[ $__arg == ${histchars[2]}* ]]
						then
							__style=${FAST_THEME_NAME}history-expansion 
						elif (( __arg_type == 3 ))
						then
							(( this_word & 3 )) && __style=${FAST_THEME_NAME}commandseparator 
						elif [[ $__arg[1,2] == '((' ]]
						then
							(( __start=_start_pos-__PBUFLEN, __end=__start+2, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}double-paren]}") 
							already_added=1 
							_FAST_COMPLEX_BRACKETS+=($__start $(( __start + 1 ))) 
							-fast-highlight-math-string
							[[ $__arg[-2,-1] == '))' ]] && {
								(( __start=_end_pos-__PBUFLEN-2, __end=__start+2, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}double-paren]}") 
								(( __delimited = __delimited ? 2 : __delimited ))
								_FAST_COMPLEX_BRACKETS+=($__start $(( __start + 1 ))) 
							}
						elif [[ $__arg == '()' ]]
						then
							_FAST_COMPLEX_BRACKETS+=($(( _start_pos-__PBUFLEN )) $(( _start_pos-__PBUFLEN + 1 ))) 
							__style=${FAST_THEME_NAME}reserved-word 
						elif [[ $__arg == $'\x28' ]]
						then
							__style=${FAST_THEME_NAME}reserved-word 
							braces_stack='R'$braces_stack 
						elif [[ $__arg == $'\x29' ]]
						then
							[[ $braces_stack = R* ]] && {
								braces_stack=${braces_stack#R} 
								__style=${FAST_THEME_NAME}reserved-word 
							}
						elif (( this_word & 14 ))
						then
							__style=${FAST_THEME_NAME}default 
						elif [[ $__arg = (';;'|';&'|';|') ]] && (( this_word & BIT_case_code ))
						then
							(( next_word = (next_word | BIT_case_item) & ~(BIT_case_code+3) ))
							__style=${FAST_THEME_NAME}default 
						elif [[ $__arg = \$\([^\(]* ]]
						then
							already_added=1 
						fi ;;
					(*) already_added=1  ;;
				esac
			fi
		elif (( in_redirection + this_word & 14 ))
		then
			case $__arg in
				(']]') [[ $braces_stack = A* ]] && {
						__style=${FAST_THEME_NAME}double-sq-bracket 
						(( __delimited = __delimited ? 2 : __delimited ))
						_FAST_COMPLEX_BRACKETS+=($(( _start_pos-__PBUFLEN )) $(( _start_pos-__PBUFLEN+1 ))) 
					} || {
						[[ $braces_stack = *A* ]] && {
							__style=${FAST_THEME_NAME}unknown-token 
							_FAST_COMPLEX_BRACKETS+=($(( _start_pos-__PBUFLEN )) $(( _start_pos-__PBUFLEN+1 ))) 
						} || __style=${FAST_THEME_NAME}default 
					}
					braces_stack=${braces_stack#A}  ;;
				(']') __style=${FAST_THEME_NAME}single-sq-bracket 
					_FAST_COMPLEX_BRACKETS+=($(( _start_pos-__PBUFLEN )))  ;;
				($'\x28') __style=${FAST_THEME_NAME}reserved-word 
					braces_stack='R'$braces_stack  ;;
				($'\x29') if (( in_array_assignment ))
					then
						in_array_assignment=0 
						(( next_word = next_word | 1 ))
						(( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}assign-array-bracket]}") 
						already_added=1 
						_FAST_COMPLEX_BRACKETS+=($__start) 
					elif [[ $braces_stack = R* ]]
					then
						braces_stack=${braces_stack#R} 
						__style=${FAST_THEME_NAME}reserved-word 
					elif [[ $braces_stack = F* ]]
					then
						__style=${FAST_THEME_NAME}builtin 
					fi ;;
				($'\x28\x29') (( FAST_HIGHLIGHT[multi_func_def] )) && (( next_word = next_word | 1 ))
					__style=${FAST_THEME_NAME}reserved-word 
					_FAST_COMPLEX_BRACKETS+=($(( _start_pos-__PBUFLEN )) $(( _start_pos-__PBUFLEN + 1 ))) 
					reply[-1]=() 
					__fast_highlight_main__command_type_cache[$active_command]="function"  ;;
				('--'*) [[ $__arg == "--" ]] && {
						_was_double_hyphen=1 
						__style=${FAST_THEME_NAME}double-hyphen-option 
					} || {
						(( !_was_double_hyphen )) && {
							[[ "$__arg" = (#b)(--[a-zA-Z0-9_]##)=(*) ]] && {
								(( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}double-hyphen-option]}") 
								(( __start=_start_pos-__PBUFLEN+1+mend[1], __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}optarg-${${${(M)match[2]:#<->}:+number}:-string}]}") 
								already_added=1 
							} || __style=${FAST_THEME_NAME}double-hyphen-option 
						} || __style=${FAST_THEME_NAME}default 
					} ;;
				('-'*) (( !_was_double_hyphen )) && __style=${FAST_THEME_NAME}single-hyphen-option  || __style=${FAST_THEME_NAME}default  ;;
				(\$\'*) (( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}dollar-quoted-argument]}") 
					-fast-highlight-dollar-string
					already_added=1  ;;
				([\"\']* | [^\"\\]##([\\][\\])#\"* | [^\'\\]##([\\][\\])#\'*) if (( this_word & 256 )) && [[ $__arg = [\'\"]* ]]
					then
						(( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}recursive-base]}") 
						if [[ -n ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}secondary]} ]]
						then
							__idx=1 
							_mybuf=$FAST_THEME_NAME 
							FAST_THEME_NAME=${${${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}secondary]}:t:r}#(XDG|LOCAL|HOME|OPT):} 
							(( ${+FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}default]} )) || source $FAST_WORK_DIR/secondary_theme.zsh
						else
							__idx=0 
						fi
						(( _start_pos-__PBUFLEN >= 0 )) && -fast-highlight-process "$PREBUFFER" "${${__arg%[\'\"]}#[\'\"]}" $(( _start_pos + 1 ))
						(( __idx )) && FAST_THEME_NAME=$_mybuf 
						already_added=1 
					else
						[[ $__arg = *([^\\][\#][\#]|"(#b)"|"(#B)"|"(#m)"|"(#c")* && $highlight_glob -ne 0 ]] && (( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}globbing-ext]}") 
						itmp=0 __workbuf=$__arg __tmp="" cdpath_dir=$__arg 
						while [[ $__workbuf = (#b)[^\"\'\\]#(([\"\'])|[\\](*))(*) ]]
						do
							[[ -n ${match[3]} ]] && {
								itmp+=${mbegin[1]} 
								[[ $__tmp = \' ]] && __workbuf=${match[3]}  || {
									itmp+=1 
									__workbuf=${match[3]:1} 
								}
							} || {
								itmp+=${mbegin[1]} 
								__workbuf=${match[4]} 
								[[ ( ${match[1]} = \" && $__tmp != \' ) || ( ${match[1]} = \' && $__tmp != \" ) ]] && {
									[[ $__tmp = [\"\'] ]] && {
										(( __start=_start_pos-__PBUFLEN+iitmp-1, __end=_start_pos-__PBUFLEN+itmp, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}${${${__tmp#\'}:+double-quoted-argument}:-single-quoted-argument}]}") 
										already_added=1 
										[[ $__tmp = \" ]] && {
											__arg=${cdpath_dir[iitmp+1,itmp-1]} 
											(( _start_pos += iitmp - 1 + 1 ))
											-fast-highlight-string
											(( _start_pos = _start_pos - iitmp + 1 - 1 ))
										}
										__tmp= 
									} || {
										iitmp=itmp 
										__tmp=${match[1]} 
									}
								}
							}
						done
						[[ $__tmp = [\"\'] ]] && {
							(( __start=_start_pos-__PBUFLEN+iitmp-1, __end=_start_pos-__PBUFLEN+__asize, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}${${${__tmp#\'}:+double-quoted-argument}:-single-quoted-argument}]}") 
							already_added=1 
							[[ $__tmp = \" ]] && {
								__arg=${cdpath_dir[iitmp+1,__asize]} 
								(( _start_pos += iitmp - 1 + 1 ))
								-fast-highlight-string
								(( _start_pos = _start_pos - iitmp + 1 - 1 ))
							}
						}
					fi ;;
				(\$\(\(*) already_added=1 
					-fast-highlight-math-string
					(( __start=_start_pos-__PBUFLEN+1, __end=__start+2, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}double-paren]}") 
					_FAST_COMPLEX_BRACKETS+=($__start $(( __start + 1 ))) 
					[[ $__arg[-2,-1] == '))' ]] && (( __start=_end_pos-__PBUFLEN-2, __end=__start+2, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}double-paren]}") 
					_FAST_COMPLEX_BRACKETS+=($__start $(( __start + 1 )))  ;;
				('`'*) (( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}back-quoted-argument]}") 
					if [[ -n ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}secondary]} ]]
					then
						__idx=1 
						_mybuf=$FAST_THEME_NAME 
						FAST_THEME_NAME=${${${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}secondary]}:t:r}#(XDG|LOCAL|HOME|OPT):} 
						(( ${+FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}default]} )) || source $FAST_WORK_DIR/secondary_theme.zsh
					else
						__idx=0 
					fi
					(( _start_pos-__PBUFLEN >= 0 )) && -fast-highlight-process "$PREBUFFER" "${${__arg%[\`]}#[\`]}" $(( _start_pos + 1 ))
					(( __idx )) && FAST_THEME_NAME=$_mybuf 
					already_added=1  ;;
				('((') (( this_word & 32 )) && {
						braces_stack='F'$braces_stack 
						__style=${FAST_THEME_NAME}double-paren 
						_FAST_COMPLEX_BRACKETS+=($(( _start_pos-__PBUFLEN )) $(( _start_pos-__PBUFLEN+1 ))) 
						__delimited=1 
					} ;;
				('))') [[ $braces_stack = F* ]] && {
						braces_stack=${braces_stack#F} 
						__style=${FAST_THEME_NAME}double-paren 
						_FAST_COMPLEX_BRACKETS+=($(( _start_pos-__PBUFLEN )) $(( _start_pos-__PBUFLEN+1 ))) 
						(( __delimited = __delimited ? 2 : __delimited ))
					} ;;
				('<<<') (( next_word = (next_word | 128) & ~3 ))
					[[ ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}here-string-tri]} != "none" ]] && (( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}here-string-tri]}") 
					already_added=1  ;;
				(*) if [[ $braces_stack = F* ]]
					then
						-fast-highlight-string
						_mybuf=$__arg 
						__idx=_start_pos 
						while [[ $_mybuf = (#b)[^a-zA-Z\{\$]#([a-zA-Z][a-zA-Z0-9]#)(*) ]]
						do
							(( __start=__idx-__PBUFLEN+${mbegin[1]}-1, __end=__idx-__PBUFLEN+${mend[1]}+1-1, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}for-loop-variable]}") 
							__idx+=${mend[1]} 
							_mybuf=${match[2]} 
						done
						_mybuf=$__arg 
						__idx=_start_pos 
						while [[ $_mybuf = (#b)[^+\<\>=:\*\|\&\^\~-]#([+\<\>=:\*\|\&\^\~-]##)(*) ]]
						do
							(( __start=__idx-__PBUFLEN+${mbegin[1]}-1, __end=__idx-__PBUFLEN+${mend[1]}+1-1, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}for-loop-operator]}") 
							__idx+=${mend[1]} 
							_mybuf=${match[2]} 
						done
						_mybuf=$__arg 
						__idx=_start_pos 
						while [[ $_mybuf = (#b)[^0-9]#([0-9]##)(*) ]]
						do
							(( __start=__idx-__PBUFLEN+${mbegin[1]}-1, __end=__idx-__PBUFLEN+${mend[1]}+1-1, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}for-loop-number]}") 
							__idx+=${mend[1]} 
							_mybuf=${match[2]} 
						done
						if [[ $__arg = (#b)[^\;]#(\;)[\ ]# ]]
						then
							(( __start=_start_pos-__PBUFLEN+${mbegin[1]}-1, __end=_start_pos-__PBUFLEN+${mend[1]}+1-1, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}for-loop-separator]}") 
						fi
						already_added=1 
					elif [[ $__arg = *([^\\][\#][\#]|"(#b)"|"(#B)"|"(#m)"|"(#c")* ]]
					then
						(( highlight_glob )) && __style=${FAST_THEME_NAME}globbing-ext  || __style=${FAST_THEME_NAME}default 
					elif [[ $__arg = ([*?]*|*[^\\][*?]*) ]]
					then
						(( highlight_glob )) && __style=${FAST_THEME_NAME}globbing  || __style=${FAST_THEME_NAME}default 
					elif [[ $__arg = \$* ]]
					then
						__style=${FAST_THEME_NAME}variable 
					elif [[ $__arg = $'\x7d' && $braces_stack = Y* && ${FAST_HIGHLIGHT[right_brace_is_recognised_everywhere]} = "1" ]]
					then
						braces_stack=${braces_stack#Y} 
						__style=${FAST_THEME_NAME}reserved-word 
						(( next_word = next_word | 16 ))
					elif [[ $__arg = (';;'|';&'|';|') ]] && (( this_word & BIT_case_code ))
					then
						(( next_word = (next_word | BIT_case_item) & ~(BIT_case_code+3) ))
						__style=${FAST_THEME_NAME}default 
					elif [[ $__arg = ${histchars[1]}* && -n ${__arg[2]} ]]
					then
						__style=${FAST_THEME_NAME}history-expansion 
					elif (( __arg_type == 3 ))
					then
						__style=${FAST_THEME_NAME}commandseparator 
					elif (( in_redirection == 2 ))
					then
						__style=${FAST_THEME_NAME}redirection 
					elif (( ${+galiases[(e)${(Q)__arg}]} ))
					then
						__style=${FAST_THEME_NAME}global-alias 
					else
						if [[ ${FAST_HIGHLIGHT[no_check_paths]} != 1 ]]
						then
							if [[ ${FAST_HIGHLIGHT[use_async]} != 1 ]]
							then
								if -fast-highlight-check-path noasync
								then
									(( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[$__style]}") 
									already_added=1 
									[[ -n ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}path_pathseparator]} && ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}path]} != ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}path_pathseparator]} ]] && {
										for ((__pos = _start_pos; __pos <= _end_pos; __pos++ )) do
											[[ ${__buf[__pos]} == "/" ]] && (( __start=__pos-__PBUFLEN, __start >= 0 )) && reply+=("$(( __start - 1 )) $__start ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}path_pathseparator]}") 
										done
									}
								else
									__style=${FAST_THEME_NAME}default 
								fi
							else
								if [[ -z ${FAST_HIGHLIGHT[cache-path-${(q)__arg}-${_start_pos}]} || $(( EPOCHSECONDS - FAST_HIGHLIGHT[cache-path-${(q)__arg}-${_start_pos}-born-at] )) -gt 8 ]]
								then
									if [[ $LASTWIDGET != *-or-beginning-search ]]
									then
										exec {PCFD}< <(-fast-highlight-check-path; sleep 5)
										command sleep 0
										FAST_HIGHLIGHT[path-queue]+=";$_start_pos $_end_pos;" 
										is-at-least 5.0.6 && __pos=1  || __pos=0 
										zle -F ${${__pos:#0}:+-w} $PCFD fast-highlight-check-path-handler
										already_added=1 
									else
										__style=${FAST_THEME_NAME}default 
									fi
								elif [[ ${FAST_HIGHLIGHT[cache-path-${(q)__arg}-${_start_pos}]%D} -eq 1 ]]
								then
									(( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}path${${(M)FAST_HIGHLIGHT[cache-path-${(q)__arg}-${_start_pos}]%D}:+-to-dir}]}") 
									already_added=1 
								else
									__style=${FAST_THEME_NAME}default 
								fi
							fi
						else
							__style=${FAST_THEME_NAME}default 
						fi
					fi ;;
			esac
		elif (( this_word & 128 ))
		then
			(( next_word = (next_word | 2) & ~129 ))
			[[ ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}here-string-text]} != "none" ]] && (( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}here-string-text]}") 
			-fast-highlight-string ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}here-string-var]:#none}
			already_added=1 
		elif (( this_word & (BIT_case_preamble + BIT_case_item) ))
		then
			if (( this_word & BIT_case_preamble ))
			then
				[[ $__arg = "in" ]] && {
					__style=${FAST_THEME_NAME}reserved-word 
					(( next_word = BIT_case_item ))
				} || {
					__style=${FAST_THEME_NAME}case-input 
					(( next_word = BIT_case_preamble ))
				}
			else
				if (( this_word & BIT_case_nempty_item == 0 )) && [[ $__arg = "esac" ]]
				then
					(( next_word = 1 ))
					__style=${FAST_THEME_NAME}reserved-word 
				elif [[ $__arg = (\(*\)|\)|\() ]]
				then
					[[ $__arg = *\) ]] && (( next_word = BIT_case_code | 1 )) || (( next_word = BIT_case_item | BIT_case_nempty_item ))
					_FAST_COMPLEX_BRACKETS+=($(( _start_pos-__PBUFLEN ))) 
					(( ${#__arg} > 1 )) && {
						_FAST_COMPLEX_BRACKETS+=($(( _start_pos+${#__arg}-1-__PBUFLEN ))) 
						(( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}case-parentheses]}") 
						(( __start=_start_pos+1-__PBUFLEN, __end=_end_pos-1-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}case-condition]}") 
						already_added=1 
					} || {
						__style=${FAST_THEME_NAME}case-parentheses 
					}
				else
					(( next_word = BIT_case_item | BIT_case_nempty_item ))
					__style=${FAST_THEME_NAME}case-condition 
				fi
			fi
		fi
		if [[ $__arg = (#b)*'#'(([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])|([0-9a-fA-F])([0-9a-fA-F])([0-9a-fA-F]))(|[^[:alnum:]]*) || $__arg = (#b)*'rgb('(([0-9a-fA-F][0-9a-fA-F](#c0,1)),([0-9a-fA-F][0-9a-fA-F](#c0,1)),([0-9a-fA-F][0-9a-fA-F](#c0,1)))* ]]
		then
			if [[ -n $match[2] ]]
			then
				if [[ $match[2] = ?? || $match[3] = ?? || $match[4] = ?? ]]
				then
					(( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end bg=#${(l:2::0:)match[2]}${(l:2::0:)match[3]}${(l:2::0:)match[4]}") 
				else
					(( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end bg=#$match[2]$match[3]$match[4]") 
				fi
			else
				(( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end bg=#$match[5]$match[6]$match[7]") 
			fi
			already_added=1 
		fi
		(( already_added == 0 )) && [[ ${FAST_HIGHLIGHT_STYLES[$__style]} != "none" ]] && (( __start=_start_pos-__PBUFLEN, __end=_end_pos-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[$__style]}") 
		if (( (__arg_type == 3) && ((this_word & (BIT_case_preamble|BIT_case_item)) == 0) ))
		then
			if [[ $__arg == ';' ]] && (( in_array_assignment ))
			then
				(( next_word = 2 | (next_word & BIT_case_code) ))
			elif [[ -n ${braces_stack[(r)A]} ]]
			then
				(( next_word = 2 | (next_word & BIT_case_code) ))
			else
				braces_stack=${braces_stack#T} 
				(( next_word = 1 | (next_word & BIT_case_code) ))
				highlight_glob=1 
				[[ $__arg != ("||"|"&&") ]] && __delimited=0  || (( __delimited = __delimited == 2 ? 1 : __delimited ))
			fi
		elif (( ( (__arg_type == 1) || (__arg_type == 2) ) && (this_word & 1) ))
		then
			__delimited=1 
			(( next_word = 1 | (next_word & (64 | BIT_case_code)) ))
		elif [[ $__arg == "repeat" ]] && (( this_word & 1 ))
		then
			__delimited=1 
			in_redirection=2 
			(( this_word = 3 ))
		fi
		_start_pos=$_end_pos 
		(( this_word = in_redirection == 0 ? next_word : this_word ))
	done
	[[ $3 != 0 ]] && return 0
	_mybuf=${__buf[1,250]} __workbuf=$_mybuf __idx=0 __pos=0 __list=() 
	while [[ $__workbuf = (#b)[^\(\)]#([\(\)])(*) ]]
	do
		if [[ ${match[1]} == \( ]]
		then
			__arg=${_mybuf[__idx+${mbegin[1]}-1,__idx+${mbegin[1]}-1+2]} 
			[[ $__arg = '$('[^\(] ]] && __list+=($__pos) 
			[[ $__arg = '$((' ]] && _mybuf[__idx+${mbegin[1]}-1]=x 
			__pos+=1 
		else
			__pos=__pos-1 
			[[ -z ${__list[(r)$__pos]} ]] && [[ $__pos -gt 0 ]] && _mybuf[__idx+${mbegin[1]}]=x 
		fi
		__idx+=${mbegin[2]}-1 
		__workbuf=${match[2]} 
	done
	if [[ "$_mybuf" = *$__nul* ]]
	then
		__nul=$'\7' 
	fi
	__inputs=(${(ps:$__nul:)${(S)_mybuf//(#b)*\$\(([^\)]#)(\)|(#e))/${mbegin[1]};${mend[1]}${__nul}}%$__nul*}) 
	if [[ "${__inputs[1]}" != "$_mybuf" && -n "${__inputs[1]}" ]]
	then
		if [[ -n ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}secondary]} ]]
		then
			__idx=1 
			__tmp=$FAST_THEME_NAME 
			FAST_THEME_NAME=${${${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}secondary]}:t:r}#(XDG|LOCAL|HOME|OPT):} 
			(( ${+FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}default]} )) || source $FAST_WORK_DIR/secondary_theme.zsh
		else
			__idx=0 
		fi
		for _mybuf in $__inputs
		do
			(( __start=${_mybuf%%;*}-__PBUFLEN-1, __end=${_mybuf##*;}-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${__tmp}recursive-base]}") 
			-fast-highlight-process "$PREBUFFER" "${__buf[${_mybuf%%;*},${_mybuf##*;}]}" $(( ${_mybuf%%;*} - 1 ))
		done
		(( __idx )) && FAST_THEME_NAME=$__tmp 
	fi
	return 0
}
-fast-highlight-string () {
	(( _start_pos-__PBUFLEN >= 0 )) || return 0
	_mybuf=$__arg 
	__idx=_start_pos 
	while [[ $_mybuf = (#b)[^\$\\]#((\$(#B)([#+^=~](#c1,2))(#c0,1)(#B)([a-zA-Z_:][a-zA-Z0-9_:]#|[0-9]##)(#b)(\[[^\]]#\])(#c0,1))|(\$[{](#B)([#+^=~](#c1,2))(#c0,1)(#b)(\([a-zA-Z0-9_:@%#]##\))(#c0,1)[a-zA-Z0-9_:#]##(\[[^\]]#\])(#c0,1)[}])|\$|[\\][\'\"\$]|[\\](*))(*) ]]
	do
		[[ -n ${match[7]} ]] && {
			__idx+=${mbegin[1]}+1 
			_mybuf=${match[7]:1} 
		} || {
			__idx+=${mbegin[1]}-1 
			_end_idx=__idx+${mend[1]}-${mbegin[1]}+1 
			_mybuf=${match[8]} 
			(( __start=__idx-__PBUFLEN, __end=_end_idx-__PBUFLEN, __start >= 0 )) && reply+=("$__start $__end ${${1:+$1}:-${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}back-or-dollar-double-quoted-argument]}}") 
			__idx=_end_idx 
		}
	done
	return 0
}
-fast-highlight-string-process () {
	emulate -LR zsh
	setopt extendedglob warncreateglobal typesetsilent
	local -A pos_to_level level_to_pos pair_map final_pairs
	local input=$1$2 _mybuf=$1$2 __style __quoting 
	integer __idx=0 __pair_idx __level=0 __start __end 
	local -a match mbegin mend
	pair_map=("(" ")" "{" "}" "[" "]") 
	while [[ $_mybuf = (#b)([^"{}()[]\\\"'"]#)((["({[]})\"'"])|[\\](*))(*) ]]
	do
		if [[ -n ${match[4]} ]]
		then
			__idx+=${mbegin[2]} 
			[[ $__quoting = \' ]] && _mybuf=${match[4]}  || {
				_mybuf=${match[4]:1} 
				(( ++ __idx ))
			}
		else
			__idx+=${mbegin[2]} 
			[[ -z $__quoting && -z ${_FAST_COMPLEX_BRACKETS[(r)$((__idx-${#PREBUFFER}-1))]} ]] && {
				if [[ ${match[2]} = ["({["] ]]
				then
					pos_to_level[$__idx]=$(( ++__level )) 
					level_to_pos[$__level]=$__idx 
				elif [[ ${match[2]} = ["]})"] ]]
				then
					if (( __level > 0 ))
					then
						__pair_idx=${level_to_pos[$__level]} 
						pos_to_level[$__idx]=$(( __level -- )) 
						[[ ${pair_map[${input[__pair_idx]}]} = ${input[__idx]} ]] && {
							final_pairs[$__idx]=$__pair_idx 
							final_pairs[$__pair_idx]=$__idx 
						}
					else
						pos_to_level[$__idx]=-1 
					fi
				fi
			}
			if [[ ${match[2]} = \" && $__quoting != \' ]]
			then
				[[ $__quoting = '"' ]] && __quoting=""  || __quoting='"' 
			fi
			if [[ ${match[2]} = \' && $__quoting != \" ]]
			then
				if [[ $__quoting = ("'"|"$'") ]]
				then
					__quoting="" 
				else
					if [[ $match[1] = *\$ ]]
					then
						__quoting="\$'" 
					else
						__quoting="'" 
					fi
				fi
			fi
			_mybuf=${match[5]} 
		fi
	done
	for __idx in ${(k)pos_to_level}
	do
		(( ${+final_pairs[$__idx]} )) && __style=${FAST_THEME_NAME}bracket-level-$(( ( (pos_to_level[$__idx]-1) % 3 ) + 1 ))  || __style=${FAST_THEME_NAME}unknown-token 
		(( __start=__idx-${#PREBUFFER}-1, __end=__idx-${#PREBUFFER}, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[$__style]}") 
	done
	if [[ $WIDGET != zle-line-finish ]]
	then
		__idx=$(( CURSOR + 1 )) 
		if (( ${+pos_to_level[$__idx]} )) && (( ${+final_pairs[$__idx]} ))
		then
			(( __start=final_pairs[$__idx]-${#PREBUFFER}-1, __end=final_pairs[$__idx]-${#PREBUFFER}, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}paired-bracket]}")  && reply+=("$CURSOR $__idx ${FAST_HIGHLIGHT_STYLES[${FAST_THEME_NAME}paired-bracket]}") 
		fi
	fi
	return 0
}
-fsh_sy_h_shappend () {
	FSH_LIST+=("$(( $1 - 1 ));;$(( $2 ))") 
}
-ftb-build-module () {
	# undefined
	builtin autoload -XUz
}
-ftb-colorize () {
	# undefined
	builtin autoload -XUz
}
-ftb-compadd () {
	local -A apre hpre dscrs _oad _mesg
	local -a isfile _opts __ expl
	zparseopts -a _opts P:=apre p:=hpre d:=dscrs X+:=expl O:=_oad A:=_oad D:=_oad f=isfile i: S: s: I: x:=_mesg r: R: W: F: M+: E: q e Q n U C J:=__ V:=__ a=__ l=__ k=__ o::=__ 1=__ 2=__
	_ftb_curcontext=${curcontext#:} 
	if (( $#_oad != 0 || ! IN_FZF_TAB )) || {
			-ftb-zstyle -m disabled-on "any"
		} || {
			-ftb-zstyle -m disabled-on "files" && [[ -n $isfile ]]
		}
	then
		builtin compadd "$@"
		return
	fi
	local -a __hits __dscr
	if (( $#dscrs == 1 ))
	then
		__dscr=("${(@P)${(v)dscrs}}") 
	fi
	builtin compadd -A __hits -D __dscr "$@"
	local ret=$? 
	if (( $#__hits == 0 ))
	then
		if is-at-least 5.9 && (( $#_mesg != 0 ))
		then
			builtin compadd -x $_mesg
		fi
		return $ret
	fi
	expl=$expl[2] 
	[[ -n $expl ]] && _ftb_groups+=$expl 
	local -a keys=(apre hpre PREFIX SUFFIX IPREFIX ISUFFIX) 
	local key expanded __tmp_value=$'<\0>' 
	for key in $keys
	do
		expanded=${(P)key} 
		if [[ -n $expanded ]]
		then
			__tmp_value+=$'\0'$key$'\0'$expanded 
		fi
	done
	if [[ -n $expl ]]
	then
		__tmp_value+=$'\0group\0'$_ftb_groups[(ie)$expl] 
	fi
	if [[ -n $isfile ]]
	then
		__tmp_value+=$'\0realdir\0'${${(Qe)~${:-$IPREFIX$hpre}}} 
	fi
	_opts+=("${(@kv)apre}" "${(@kv)hpre}" $isfile) 
	__tmp_value+=$'\0args\0'${(pj:\1:)_opts} 
	if (( $+builtins[fzf-tab-compcap-generate] ))
	then
		fzf-tab-compcap-generate __hits __dscr __tmp_value
	else
		local dscr word i
		for i in {1..$#__hits}
		do
			word=$__hits[i] dscr=$__dscr[i] 
			if [[ -n $dscr ]]
			then
				dscr=${dscr//$'\n'} 
			elif [[ -n $word ]]
			then
				dscr=$word 
			fi
			_ftb_compcap+=$dscr$'\2'$__tmp_value$'\0word\0'$word 
		done
	fi
	builtin compadd "$@"
}
-ftb-complete () {
	local -Ua _ftb_groups
	local choice choices _ftb_curcontext continuous_trigger print_query accept_line bs=$'\2' nul=$'\0' 
	local ret=0 
	(( $+builtins[fzf-tab-compcap-generate] )) && fzf-tab-compcap-generate -i
	COLUMNS=500 _ftb__main_complete "$@" || ret=$? 
	(( $+builtins[fzf-tab-compcap-generate] )) && fzf-tab-compcap-generate -o
	emulate -L zsh -o extended_glob
	local _ftb_query _ftb_complist=() _ftb_headers=() command opts 
	-ftb-generate-complist
	-ftb-zstyle -s continuous-trigger continuous_trigger || {
		[[ $OSTYPE == msys ]] && continuous_trigger=//  || continuous_trigger=/ 
	}
	case $#_ftb_complist in
		(0) return 1 ;;
		(1) choices=("EXPECT_KEY" "${_ftb_compcap[1]%$bs*}") 
			if (( _ftb_continue_last ))
			then
				choices[1]=$continuous_trigger 
			fi ;;
		(*) if (( ! _ftb_continue_last )) && [[ $compstate[insert] == *"unambiguous" ]] && [[ -n $compstate[unambiguous] ]] && [[ "$compstate[unambiguous]" != "$compstate[quote]$IPREFIX$PREFIX$compstate[quote]" ]]
			then
				compstate[list]= 
				compstate[insert]=unambiguous 
				_ftb_finish=1 
				return 0
			fi
			-ftb-generate-query
			-ftb-generate-header
			-ftb-zstyle -s print-query print_query || print_query=alt-enter 
			-ftb-zstyle -s accept-line accept_line
			choices=("${(@f)"$(builtin print -rl -- $_ftb_headers $_ftb_complist | -ftb-fzf)"}") 
			ret=$? 
			if [[ $choices[2] == $print_query ]] || [[ -n $choices[1] && $#choices == 1 ]]
			then
				local -A v=("${(@0)${_ftb_compcap[1]}}") 
				local -a args=("${(@ps:\1:)v[args]}") 
				[[ -z $args[1] ]] && args=() 
				IPREFIX=$v[IPREFIX] PREFIX=$v[PREFIX] SUFFIX=$v[SUFFIX] ISUFFIX=$v[ISUFFIX] 
				builtin compadd "${args[@]:--Q}" -Q -- $choices[1]
				compstate[list]= 
				compstate[insert]= 
				if (( $#choices[1] > 0 ))
				then
					compstate[insert]='1' 
					[[ $RBUFFER == ' '* ]] || compstate[insert]+=' ' 
				fi
				_ftb_finish=1 
				return $ret
			fi
			choices[1]=() 
			choices=("${(@)${(@)choices%$nul*}#*$nul}") 
			unset CTXT ;;
	esac
	if [[ -n $choices[1] && $choices[1] == $continuous_trigger ]]
	then
		typeset -gi _ftb_continue=1 
		typeset -gi _ftb_continue_last=1 
	fi
	if [[ -n $choices[1] && $choices[1] == $accept_line ]]
	then
		typeset -gi _ftb_accept=1 
	fi
	choices[1]=() 
	_ftb_choices=("${(@)choices}") 
	compstate[list]= 
	compstate[insert]= 
	return $ret
}
-ftb-fzf () {
	# undefined
	builtin autoload -XUz
}
-ftb-generate-complist () {
	# undefined
	builtin autoload -XUz
}
-ftb-generate-header () {
	# undefined
	builtin autoload -XUz
}
-ftb-generate-query () {
	# undefined
	builtin autoload -XUz
}
-ftb-version () {
	# undefined
	builtin autoload -XUz
}
-ftb-zstyle () {
	zstyle $1 ":fzf-tab:$_ftb_curcontext" ${@:2}
}
.fast-make-targets () {
	# undefined
	builtin autoload -XUz
}
.fast-read-ini-file () {
	# undefined
	builtin autoload -XUz
}
.fast-run-command () {
	# undefined
	builtin autoload -XUz
}
.fast-run-git-command () {
	# undefined
	builtin autoload -XUz
}
.fast-zts-read-all () {
	# undefined
	builtin autoload -XUz
}
/fshdbg () {
	print -r -- "$@" >>| /tmp/reply
}
_SUSEconfig () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
__arguments () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
__starship_get_time () {
	(( STARSHIP_CAPTURED_TIME = int(rint(EPOCHREALTIME * 1000)) ))
}
__zoxide_cd () {
	\builtin cd -- "$@"
}
__zoxide_doctor () {
	[[ ${_ZO_DOCTOR:-1} -ne 0 ]] || return 0
	[[ ${chpwd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]] || return 0
	_ZO_DOCTOR=0 
	\builtin printf '%s\n' 'zoxide: detected a possible configuration issue.' 'Please ensure that zoxide is initialized right at the end of your shell configuration file (usually ~/.zshrc).' '' 'If the issue persists, consider filing an issue at:' 'https://github.com/ajeetdsouza/zoxide/issues' '' 'Disable this message by setting _ZO_DOCTOR=0.' '' >&2
}
__zoxide_hook () {
	\command zoxide add -- "$(__zoxide_pwd)"
}
__zoxide_pwd () {
	\builtin pwd -L
}
__zoxide_z () {
	__zoxide_doctor
	if [[ "$#" -eq 0 ]]
	then
		__zoxide_cd ~
	elif [[ "$#" -eq 1 ]] && {
			[[ -d "$1" ]] || [[ "$1" = '-' ]] || [[ "$1" =~ ^[-+][0-9]$ ]]
		}
	then
		__zoxide_cd "$1"
	elif [[ "$#" -eq 2 ]] && [[ "$1" = "--" ]]
	then
		__zoxide_cd "$2"
	else
		\builtin local result
		result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -- "$@")"  && __zoxide_cd "${result}"
	fi
}
__zoxide_zi () {
	__zoxide_doctor
	\builtin local result
	result="$(\command zoxide query --interactive -- "$@")"  && __zoxide_cd "${result}"
}
_a2ps () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_a2utils () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_aap () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_abcde () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_absolute_command_paths () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ack () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_acpi () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_acpitool () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_acroread () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_adb () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_add-zle-hook-widget () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_add-zsh-hook () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_alias () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_aliases () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_all_labels () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_all_matches () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_alsa-utils () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_alternative () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_analyseplugin () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ansible () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ant () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_antiword () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_apachectl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_apm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_approximate () {
	(( ! IN_FZF_TAB )) || unfunction compadd
	_ftb__approximate
	(( ! IN_FZF_TAB )) || functions[compadd]=$functions[-ftb-compadd] 
}
_apt () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_apt-file () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_apt-move () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_apt-show-versions () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_aptitude () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_arch_archives () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_arch_namespace () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_arg_compile () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_arguments () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_arp () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_arping () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_arrays () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_asciidoctor () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_asciinema () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_asdf () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_assign () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_at () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_attr () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_augeas () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_auto-apt () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_autocd () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_avahi () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_awk () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_axi-cache () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_base64 () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_basename () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_basenc () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bash () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bash_completions () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bat () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_baudrates () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_baz () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_be_name () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_beadm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_beep () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bibtex () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bind_addresses () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bindkey () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bison () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bittorrent () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bogofilter () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bpf_filters () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bpython () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_brace_parameter () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_brctl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_brew () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_bsd_disks () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bsd_pkg () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bsdconfig () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bsdinstall () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_btrfs () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bts () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bug () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_builtin () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bun () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_bzip2 () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_bzr () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cabal () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cache_invalid () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_caffeinate () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cal () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_calendar () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_call_function () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_call_program () {
	local -xi COLUMNS=999 
	local curcontext="${curcontext}" tmp err_fd=-1 clocale='_comp_locale;' 
	local -a prefix
	if [[ "$1" = -p ]]
	then
		shift
		if (( $#_comp_priv_prefix ))
		then
			curcontext="${curcontext%:*}/${${(@M)_comp_priv_prefix:#^*[^\\]=*}[1]}:" 
			zstyle -t ":completion:${curcontext}:${1}" gain-privileges && prefix=($_comp_priv_prefix) 
		fi
	elif [[ "$1" = -l ]]
	then
		shift
		clocale='' 
	fi
	if (( ${debug_fd:--1} > 2 )) || [[ ! -t 2 ]]
	then
		exec {err_fd}>&2
	else
		exec {err_fd}> /dev/null
	fi
	{
		if zstyle -s ":completion:${curcontext}:${1}" command tmp
		then
			if [[ "$tmp" = -* ]]
			then
				eval $clocale "$tmp[2,-1]" "$argv[2,-1]"
			else
				eval $clocale $prefix "$tmp"
			fi
		else
			eval $clocale $prefix "$argv[2,-1]"
		fi 2>&$err_fd
	} always {
		exec {err_fd}>&-
	}
}
_canonical_paths () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_capabilities () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cargo () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_cat () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ccal () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cd () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cdbs-edit-patch () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cdcd () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cdr () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cdrdao () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cdrecord () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_chattr () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_chcon () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_chflags () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_chkconfig () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_chmod () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_choom () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_chown () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_chroot () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_chrt () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_chsh () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cksum () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_clay () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cmdambivalent () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cmdstring () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cmp () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_code () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_column () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_combination () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_comm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_command () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_command_names () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_comp_locale () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_compadd () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_compdef () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_complete () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_complete_debug () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_complete_help () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_complete_help_generic () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_complete_tag () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_completers () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_composer () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_compress () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_condition () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_configure () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_coreadm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_correct () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_correct_filename () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_correct_word () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cowsay () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cp () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cpio () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cplay () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cpupower () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_crontab () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cryptsetup () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cscope () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_csplit () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cssh () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_csup () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ctags () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ctags_tags () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cu () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_curl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cut () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cvs () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cvsup () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cygcheck () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cygpath () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cygrunsrv () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cygserver () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_cygstart () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dak () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_darcs () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_date () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_date_formats () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dates () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dbus () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dchroot () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dchroot-dsa () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dconf () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dcop () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dcut () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dd () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_deb_architectures () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_deb_codenames () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_deb_files () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_deb_packages () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_debbugs_bugnumber () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_debchange () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_debcheckout () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_debdiff () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_debfoster () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_deborphan () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_debsign () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_debsnap () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_debuild () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_default () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_defaults () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_delimiters () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_describe () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_description () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_devtodo () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_df () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dhclient () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dhcpinfo () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dict () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dict_words () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_diff () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_diff3 () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_diff_options () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_diffstat () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dig () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dir_list () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_directories () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_directory_stack () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dirs () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_disable () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dispatch () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_django () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dkms () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dladm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dlocate () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dmesg () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dmidecode () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dnf () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dns_types () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_doas () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_docker () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_domains () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dos2unix () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dpatch-edit-patch () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dpkg () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dpkg-buildpackage () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dpkg-cross () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dpkg-repack () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dpkg_source () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dput () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_drill () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dropbox () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dscverify () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dsh () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dtrace () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dtruss () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_du () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dumpadm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dumper () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dupload () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dvi () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_dynamic_directory_name () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_e2label () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ecasound () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_echotc () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_echoti () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ed () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_elfdump () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_elinks () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_email_addresses () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_emulate () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_enable () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_enscript () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_entr () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_env () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_eog () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_equal () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_espeak () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_etags () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ethtool () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_evince () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_exec () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_expand () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_expand_alias () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_expand_word () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_extensions () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_external_pwds () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_eza () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_fakeroot () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fast-theme () {
	# undefined
	builtin autoload -XUz /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting
}
_fbsd_architectures () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fbsd_device_types () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fc () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fd () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_feh () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fetch () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fetchmail () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ffmpeg () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_figlet () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_file_descriptors () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_file_flags () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_file_modes () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_file_systems () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_files () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_find () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_find_net_interfaces () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_findmnt () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_finger () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fink () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_first () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_flac () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_flex () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_floppy () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_flowadm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fmadm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fmt () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fold () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fortune () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_free () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_freebsd-update () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fs_usage () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fsh () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fstat () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ftb__approximate () {
	[[ _matcher_num -gt 1 || "${#:-$PREFIX$SUFFIX}" -le 1 ]] && return 1
	local _comp_correct _correct_expl _correct_group comax cfgacc match
	local oldcontext="${curcontext}" opm="$compstate[pattern_match]" 
	local dounfunction
	integer ret=1 
	if [[ "$1" = -a* ]]
	then
		cfgacc="${1[3,-1]}" 
	elif [[ "$1" = -a ]]
	then
		cfgacc="$2" 
	else
		zstyle -s ":completion:${curcontext}:" max-errors cfgacc || cfgacc='2 numeric' 
	fi
	if [[ "$cfgacc" = *numeric* && ${NUMERIC:-1} -ne 1 ]]
	then
		[[ "$cfgacc" = *not-numeric* ]] && return 1
		comax="${NUMERIC:-1}" 
	else
		comax="${cfgacc//[^0-9]}" 
	fi
	[[ "$comax" -lt 1 ]] && return 1
	_tags corrections original
	{
		if (( ! $+functions[compadd] ))
		then
			dounfunction=1 
			compadd () {
				local ppre="$argv[(I)-p]" 
				[[ ${argv[(I)-[a-zA-Z]#U[a-zA-Z]#]} -eq 0 && "${#:-$PREFIX$SUFFIX}" -le _comp_correct ]] && return
				if [[ "$PREFIX" = \~* && ( ppre -eq 0 || "$argv[ppre+1]" != \~* ) ]]
				then
					PREFIX="~(#a${_comp_correct})${PREFIX[2,-1]}" 
				else
					PREFIX="(#a${_comp_correct})$PREFIX" 
				fi
				(( $_correct_group && ${${argv[1,(r)-(|-)]}[(I)-*[JV]]} )) && _correct_expl[_correct_group]=${argv[1,(r)-(-|)][(R)-*[JV]]} 
				builtin compadd "$_correct_expl[@]" "$@"
			}
		fi
		_comp_correct=1 
		[[ -z "$compstate[pattern_match]" ]] && compstate[pattern_match]='*' 
		while [[ _comp_correct -le comax ]]
		do
			curcontext="${oldcontext/(#b)([^:]#:[^:]#:)/${match[1][1,-2]}-${_comp_correct}:}" 
			_description corrections _correct_expl corrections "e:$_comp_correct" "o:$PREFIX$SUFFIX"
			_correct_group="$_correct_expl[(I)-*[JV]]" 
			if _complete
			then
				if zstyle -t ":completion:${curcontext}:" insert-unambiguous && [[ "${#compstate[unambiguous]}" -ge "${#:-$PREFIX$SUFFIX}" ]]
				then
					compstate[pattern_insert]=unambiguous 
				elif _requested original && {
						[[ compstate[nmatches] -gt 1 ]] || zstyle -t ":completion:${curcontext}:" original
					}
				then
					local expl
					_description -V original expl original
					builtin compadd "$expl[@]" -U -Q - "$PREFIX$SUFFIX"
					[[ "$compstate[list]" != list* ]] && compstate[list]="$compstate[list] force" 
				fi
				compstate[pattern_match]="$opm" 
				ret=0 
				break
			fi
			[[ "${#:-$PREFIX$SUFFIX}" -le _comp_correct+1 ]] && break
			(( _comp_correct++ ))
		done
	} always {
		[[ -n $dounfunction ]] && (( $+functions[compadd] )) && unfunction compadd
	}
	(( ret == 0 )) && return 0
	compstate[pattern_match]="$opm" 
	return 1
}
_ftb__main_complete () {
	local IFS=$' \t\n\0' 
	eval "$_comp_setup"
	local func funcs ret=1 tmp _compskip format nm call match min max i num _completers _completer _completer_num curtag _comp_force_list _matchers _matcher _c_matcher _matcher_num _comp_tags _comp_mesg mesg str context state state_descr line opt_args val_args curcontext="$curcontext" _last_nmatches=-1 _last_menu_style _def_menu_style _menu_style sel _tags_level=0 _saved_exact="${compstate[exact]}" _saved_lastprompt="${compstate[last_prompt]}" _saved_list="${compstate[list]}" _saved_insert="${compstate[insert]}" _saved_colors="$ZLS_COLORS" _saved_colors_set=${+ZLS_COLORS} _ambiguous_color='' 
	local _comp_priv_prefix
	unset _comp_priv_prefix
	local -a precommands
	local -ar builtin_precommands=(- builtin eval exec nocorrect noglob time) 
	typeset -U _lastdescr _comp_ignore _comp_colors
	{
		[[ -z "$curcontext" ]] && curcontext=::: 
		zstyle -s ":completion:${curcontext}:" insert-tab tmp || tmp=yes 
		if [[ ( "$tmp" = *pending(|[[:blank:]]*) && PENDING -gt 0 ) || ( "$tmp" = *pending=(#b)([0-9]##)(|[[:blank:]]*) && PENDING -ge $match[1] ) ]]
		then
			compstate[insert]=tab 
			return 0
		fi
		if [[ "$compstate[insert]" = tab* ]]
		then
			if [[ "$tmp" = (|*[[:blank:]])(yes|true|on|1)(|[[:blank:]]*) ]]
			then
				if [[ "$curcontext" != :* || -z "$compstate[vared]" ]] || zstyle -t ":completion:vared${curcontext}:" insert-tab
				then
					return 0
				fi
			fi
			compstate[insert]="${compstate[insert]//tab /}" 
		fi
		if [[ "$compstate[pattern_match]" = "*" && "$_lastcomp[unambiguous]" = "$PREFIX" && -n "$_lastcomp[unambiguous_cursor]" ]]
		then
			integer upos="$_lastcomp[unambiguous_cursor]" 
			SUFFIX="$PREFIX[upos,-1]$SUFFIX" 
			PREFIX="$PREFIX[1,upos-1]" 
		fi
		if [[ -z "$compstate[quote]" ]]
		then
			if [[ -o equals ]] && compset -P 1 '='
			then
				compstate[context]=equal 
			elif [[ "$PREFIX" != */* && "$PREFIX[1]" = '~' ]]
			then
				if [[ "$PREFIX" = '~['[^\]]# ]]
				then
					compset -p 2
					compset -S '\]*'
					compstate[context]=subscript 
					[[ -n $_comps[-subscript-] ]] && $_comps[-subscript-] && return
				else
					compset -p 1
					compstate[context]=tilde 
				fi
			fi
		fi
		_setup default
		_def_menu_style=("$_last_menu_style[@]") 
		_last_menu_style=() 
		if zstyle -s ":completion:${curcontext}:default" list-prompt tmp
		then
			LISTPROMPT="$tmp" 
			zmodload -i zsh/complist
		fi
		if zstyle -s ":completion:${curcontext}:default" select-prompt tmp
		then
			MENUPROMPT="$tmp" 
			zmodload -i zsh/complist
		fi
		if zstyle -s ":completion:${curcontext}:default" select-scroll tmp
		then
			MENUSCROLL="$tmp" 
			zmodload -i zsh/complist
		fi
		if (( $# ))
		then
			if [[ "$1" = - ]]
			then
				if [[ $# -lt 3 ]]
				then
					_completers=() 
				else
					_completers=("$2") 
					call=yes 
				fi
			else
				_completers=("$@") 
			fi
		else
			zstyle -a ":completion:${curcontext}:" completer _completers || _completers=(_complete _ignored) 
		fi
		_completer_num=1 
		integer SECONDS=0 
		TRAPINT () {
			zle -M "Killed by signal in ${funcstack[2]} after ${SECONDS}s"
			zle -R
			return 130
		}
		TRAPQUIT () {
			zle -M "Killed by signal in ${funcstack[2]} after ${SECONDS}s"
			zle -R
			return 131
		}
		funcs=("$compprefuncs[@]") 
		compprefuncs=() 
		for func in "$funcs[@]"
		do
			"$func"
		done
		for tmp in "$_completers[@]"
		do
			if [[ -n "$call" ]]
			then
				_completer="${tmp}" 
			elif [[ "$tmp" = *:-* ]]
			then
				_completer="${${tmp%:*}[2,-1]//_/-}${tmp#*:}" 
				tmp="${tmp%:*}" 
			elif [[ $tmp = *:* ]]
			then
				_completer="${tmp#*:}" 
				tmp="${tmp%:*}" 
			else
				_completer="${tmp[2,-1]//_/-}" 
			fi
			curcontext="${curcontext/:[^:]#:/:${_completer}:}" 
			zstyle -t ":completion:${curcontext}:" show-completer && zle -R "Trying completion for :completion:${curcontext}"
			zstyle -a ":completion:${curcontext}:" matcher-list _matchers || _matchers=('') 
			_matcher_num=1 
			_matcher='' 
			for _c_matcher in "$_matchers[@]"
			do
				if [[ "$_c_matcher" == +* ]]
				then
					_matcher="$_matcher $_c_matcher[2,-1]" 
				else
					_matcher="$_c_matcher" 
				fi
				_comp_mesg= 
				if [[ -n "$call" ]]
				then
					if "${(@)argv[3,-1]}"
					then
						ret=0 
						break 2
					fi
				elif "$tmp"
				then
					ret=0 
					break 2
				fi
				(( _matcher_num++ ))
			done
			[[ -n "$_comp_mesg" ]] && break
			(( _completer_num++ ))
		done
		curcontext="${curcontext/:[^:]#:/::}" 
		if [[ $compstate[old_list] = keep ]]
		then
			nm=$_lastcomp[nmatches] 
		else
			nm=$compstate[nmatches] 
		fi
		if [[ $compstate[old_list] = keep || nm -gt 1 ]]
		then
			[[ _last_nmatches -ge 0 && _last_nmatches -ne nm ]] && _menu_style=("$_last_menu_style[@]" "$_menu_style[@]") 
			tmp=$(( compstate[list_lines] + BUFFERLINES + 1 )) 
			_menu_style=("$_menu_style[@]" "$_def_menu_style[@]") 
			if [[ "$compstate[list]" = *list(| *) && tmp -gt LINES && ( -n "$_menu_style[(r)select=long-list]" || -n "$_menu_style[(r)(yes|true|on|1)=long-list]" ) ]]
			then
				compstate[insert]=menu 
			elif [[ "$compstate[insert]" = "$_saved_insert" ]]
			then
				if [[ -n "$compstate[insert]" && -n "$_menu_style[(r)(yes|true|1|on)=long]" && tmp -gt LINES ]]
				then
					compstate[insert]=menu 
				else
					sel=("${(@M)_menu_style:#(yes|true|1|on)*}") 
					if (( $#sel ))
					then
						min=9999999 
						for i in "$sel[@]"
						do
							if [[ "$i" = *\=[0-9]* ]]
							then
								num="${i#*\=}" 
								[[ num -lt 0 ]] && num=0 
							elif [[ "$i" != *\=* ]]
							then
								num=0 
							else
								num=9999999 
							fi
							[[ num -lt min ]] && min="$num" 
							(( min )) || break
						done
					fi
					sel=("${(@M)_menu_style:#(no|false|0|off)*}") 
					if (( $#sel ))
					then
						max=9999999 
						for i in "$sel[@]"
						do
							if [[ "$i" = *\=[0-9]* ]]
							then
								num="${i#*\=}" 
								[[ num -lt 0 ]] && num=0 
							elif [[ "$i" != *\=* ]]
							then
								num=0 
							else
								num=9999999 
							fi
							[[ num -lt max ]] && max="$num" 
							(( max )) || break
						done
					fi
					if [[ ( -n "$min" && nm -ge min && ( -z "$max" || nm -lt max ) ) || ( -n "$_menu_style[(r)auto*]" && "$compstate[insert]" = automenu ) ]]
					then
						compstate[insert]=menu 
					elif [[ -n "$max" && nm -ge max ]]
					then
						compstate[insert]=unambiguous 
					elif [[ -n "$_menu_style[(r)auto*]" && "$compstate[insert]" != automenu ]]
					then
						compstate[insert]=automenu-unambiguous 
					fi
				fi
			fi
			if [[ "$compstate[insert]" = *menu* ]]
			then
				[[ "$MENUSELECT" = 00 ]] && MENUSELECT=0 
				if [[ -n "$_menu_style[(r)no-select*]" ]]
				then
					unset MENUSELECT
				elif [[ -n "$_menu_style[(r)select=long*]" ]]
				then
					if [[ tmp -gt LINES ]]
					then
						zmodload -i zsh/complist
						MENUSELECT=00 
					fi
				fi
				if [[ "$MENUSELECT" != 00 ]]
				then
					sel=("${(@M)_menu_style:#select*}") 
					if (( $#sel ))
					then
						min=9999999 
						for i in "$sel[@]"
						do
							if [[ "$i" = *\=[0-9]* ]]
							then
								num="${i#*\=}" 
								[[ num -lt 0 ]] && num=0 
							elif [[ "$i" != *\=* ]]
							then
								num=0 
							else
								num=9999999 
							fi
							[[ num -lt min ]] && min="$num" 
							(( min )) || break
						done
						zmodload -i zsh/complist
						MENUSELECT="$min" 
					else
						unset MENUSELECT
					fi
				fi
				if [[ -n "$MENUSELECT" ]]
				then
					if [[ -n "$_menu_style[(r)interactive*]" ]]
					then
						MENUMODE=interactive 
					elif [[ -n "$_menu_style[(r)search*]" ]]
					then
						if [[ -n "$_menu_style[(r)*backward*]" ]]
						then
							MENUMODE=search-backward 
						else
							MENUMODE=search-forward 
						fi
					else
						unset MENUMODE
					fi
				fi
			fi
		elif [[ nm -lt 1 && -n "$_comp_mesg" ]]
		then
			compstate[insert]='' 
			compstate[list]='list force' 
		elif [[ nm -eq 0 && -z "$_comp_mesg" && $#_lastdescr -ne 0 && $compstate[old_list] != keep ]] && zstyle -s ":completion:${curcontext}:warnings" format format
		then
			compstate[list]='list force' 
			compstate[insert]='' 
			tmp=("\`${(@)^_lastdescr:#}'") 
			case $#tmp in
				(1) str="$tmp[1]"  ;;
				(2) str="$tmp[1] or $tmp[2]"  ;;
				(*) str="${(j:, :)tmp[1,-2]}, or $tmp[-1]"  ;;
			esac
			_setup warnings
			zformat -f mesg "$format" "d:$str" "D:${(F)${(@)_lastdescr:#}}"
			compadd -x "$mesg"
		fi
		if [[ -n "$_ambiguous_color" ]]
		then
			local toquote='[=\(\)\|~^?*[\]#<>]' 
			local prefix=${${compstate[unambiguous]}[1,${compstate[unambiguous_cursor]}-1]} 
			[[ -n $prefix ]] && _comp_colors+=("=(#i)${prefix[1,-2]//?/(}${prefix[1,-2]//(#m)?/${MATCH/$~toquote/\\$MATCH}|)}${prefix[-1]//(#m)$~toquote/\\$MATCH}(#b)(?|)*==$_ambiguous_color") 
		fi
		[[ "$_comp_force_list" = always || ( "$_comp_force_list" = ?* && nm -ge _comp_force_list ) ]] && compstate[list]="${compstate[list]//messages} force" 
	} always {
		if [[ "$compstate[old_list]" = keep ]]
		then
			if [[ $_saved_colors_set = 1 ]]
			then
				ZLS_COLORS="$_saved_colors" 
			else
				unset ZLS_COLORS
			fi
		elif (( $#_comp_colors ))
		then
			ZLS_COLORS="${(j.:.)_comp_colors}" 
		else
			unset ZLS_COLORS
		fi
	}
	funcs=("$comppostfuncs[@]") 
	comppostfuncs=() 
	for func in "$funcs[@]"
	do
		"$func"
	done
	_lastcomp=("${(@kv)compstate}") 
	_lastcomp[nmatches]=$nm 
	_lastcomp[completer]="$_completer" 
	_lastcomp[prefix]="$PREFIX" 
	_lastcomp[suffix]="$SUFFIX" 
	_lastcomp[iprefix]="$IPREFIX" 
	_lastcomp[isuffix]="$ISUFFIX" 
	_lastcomp[qiprefix]="$QIPREFIX" 
	_lastcomp[qisuffix]="$QISUFFIX" 
	_lastcomp[tags]="$_comp_tags" 
	return ret
}
_functions () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fuse_arguments () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fuse_values () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fuser () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fusermount () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fw_update () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_fzf-tab-apply () {
	local choice bs=$'\2' 
	for choice in "$_ftb_choices[@]"
	do
		local -A v=("${(@0)${_ftb_compcap[(r)${(b)choice}$bs*]#*$bs}}") 
		local -a args=("${(@ps:\1:)v[args]}") 
		[[ -z $args[1] ]] && args=() 
		IPREFIX=${v[IPREFIX]-} PREFIX=${v[PREFIX]-} SUFFIX=${v[SUFFIX]-} ISUFFIX=${v[ISUFFIX]-} 
		builtin compadd "${args[@]:--Q}" -Q -- "$v[word]"
	done
	compstate[list]= 
	if (( $#_ftb_choices == 1 ))
	then
		compstate[insert]='1' 
		[[ $RBUFFER == ' '* ]] || compstate[insert]+=' ' 
	elif (( $#_ftb_choices > 1 ))
	then
		compstate[insert]='all' 
	fi
}
_fzf_comprun () {
	local command=$1 
	shift
	case "$command" in
		(cd) fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
		(export | unset) fzf --preview "eval 'echo $'{}" "$@" ;;
		(ssh) fzf --preview 'dig {}' "$@" ;;
		(*) fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
	esac
}
_gcc () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gcore () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gdb () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_geany () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gem () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_generic () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_genisoimage () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_getclip () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_getconf () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_getent () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_getfacl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_getmail () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_getopt () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gh () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_ghostscript () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ghostty () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_git () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_git-buildpackage () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_global () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_global_tags () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_globflags () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_globqual_delims () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_globquals () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gnome-gv () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gnu_generic () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gnupod () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gnutls () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_go () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gopass () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_gpasswd () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gpg () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gphoto2 () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gprof () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gqview () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gradle () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_graphicsmagick () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_grep () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_grep-excuses () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_groff () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_groups () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_growisofs () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gsettings () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gstat () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_guard () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_guilt () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gv () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_gzip () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_hash () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_have_glob_qual () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_hdiutil () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_head () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_hexdump () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_history () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_history_complete_word () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_history_modifiers () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_host () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_hostname () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_hosts () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_htop () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_hwinfo () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_iconv () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_iconvconfig () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_id () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ifconfig () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_iftop () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ignored () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_imagemagick () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_in_vared () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_inetadm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_init_d () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_initctl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_install () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_invoke-rc.d () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ionice () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_iostat () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ip () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ipadm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ipfw () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ipsec () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ipset () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_iptables () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_irssi () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ispell () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_iwconfig () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_jail () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_jails () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_java () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_java_class () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_jexec () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_jls () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_jobs () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_jobs_bg () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_jobs_builtin () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_jobs_fg () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_joe () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_join () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_jot () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_jq () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_kdeconnect () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_kdump () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_kfmclient () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_kill () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_killall () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_kld () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_knock () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_kpartx () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ktrace () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ktrace_points () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_kvno () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_last () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ld_debug () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ldap () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ldconfig () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ldd () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_less () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lha () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_libvirt () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lighttpd () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_limit () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_limits () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_links () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lintian () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_list () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_list_files () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lldb () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ln () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_loadkeys () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_locale () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_localedef () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_locales () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_locate () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_logger () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_logical_volumes () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_login_classes () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_look () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_losetup () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lp () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ls () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lsattr () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lsblk () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lscfg () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lsd () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_lsdev () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lslv () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lsns () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lsof () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lspv () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lsusb () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lsvg () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ltrace () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lua () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_luarocks () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_lynx () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lz4 () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_lzop () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mac_applications () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mac_files_for_application () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_madison () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mail () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mailboxes () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_main_complete () {
	-ftb-complete "$@"
}
_make () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_make-kpkg () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_man () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mat () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mat2 () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_match () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_math () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_math_params () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_matlab () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_md5sum () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mdadm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mdfind () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mdls () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mdutil () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_members () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mencal () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_menu () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mere () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mergechanges () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_message () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mh () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mii-tool () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mime_types () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mixerctl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mkdir () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mkfifo () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mknod () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mkshortcut () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mktemp () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mkzsh () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_module () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_module-assistant () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_module_math_func () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_modutils () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mondo () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_monotone () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_moosic () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mosh () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_most_recent_file () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mount () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mozilla () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mpc () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mplayer () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mt () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mtools () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mtr () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_multi_parts () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mupdf () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mutt () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mv () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_my_accounts () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_myrepos () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mysql_utils () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_mysqldiff () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_nautilus () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_nbsd_architectures () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ncftp () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_nedit () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_net_interfaces () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_netcat () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_netscape () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_netstat () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_networkmanager () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_networksetup () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_newsgroups () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_next_label () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_next_tags () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_nginx () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ngrep () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_nice () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_nkf () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_nl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_nm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_nmap () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_normal () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_nothing () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_npm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_nsenter () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_nslookup () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_numbers () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_numfmt () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_nvram () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_objdump () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_object_classes () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_object_files () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_obsd_architectures () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_od () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_okular () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_oldlist () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_open () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_openstack () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_opkg () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_options () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_options_set () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_options_unset () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_opustools () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_osascript () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_osc () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_other_accounts () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_otool () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pack () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pandoc () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_parallel () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_parameter () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_parameters () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pass () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_paste () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_patch () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_patchutils () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_path_commands () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_path_files () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pax () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pbcopy () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pbm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pbuilder () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pdf () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pdftk () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_perf () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_perforce () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_perl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_perl_basepods () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_perl_modules () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_perldoc () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pfctl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pfexec () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pgids () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pgrep () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_php () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_physical_volumes () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pick_variant () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_picocom () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pidof () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pids () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pine () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ping () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pip () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pipx () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_piuparts () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pkg-config () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pkg5 () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pkg_instance () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pkgadd () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pkgin () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pkginfo () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pkgrm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pkgtool () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_plutil () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pmap () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pon () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_portaudit () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_portlint () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_portmaster () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ports () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_portsnap () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_postfix () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_postgresql () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_postscript () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_powerd () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pr () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_precommand () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_prefix () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_print () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_printenv () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_printers () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_process_names () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_procstat () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_prompt () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_prove () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_prstat () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ps () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ps1234 () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pscp () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pspdf () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_psutils () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ptree () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ptx () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pump () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_putclip () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pv () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pwgen () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_pydoc () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_python () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_python_modules () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_qdbus () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_qemu () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_qiv () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_qtplay () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_quilt () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_rake () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ranlib () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_rar () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_rcctl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_rclone () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_rcs () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_rdesktop () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_read () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_read_comp () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_readelf () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_readlink () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_readshortcut () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_rebootin () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_redirect () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_regex_arguments () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_regex_words () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_remote_files () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_renice () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_reprepro () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_requested () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_retrieve_cache () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_retrieve_mac_apps () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_rg () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_ri () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_rlogin () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_rm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_rmdir () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_route () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_routing_domains () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_routing_tables () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_rpm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_rrdtool () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_rsync () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_rubber () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ruby () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_run-help () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_runit () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_samba () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_savecore () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_say () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sbuild () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sc_usage () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sccs () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sched () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_schedtool () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_schroot () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_scl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_scons () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_screen () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_script () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_scselect () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_scutil () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_seafile () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sed () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_selinux_contexts () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_selinux_roles () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_selinux_types () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_selinux_users () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sep_parts () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_seq () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sequence () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_service () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_services () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_set () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_set_command () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_setfacl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_setopt () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_setpriv () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_setsid () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_setup () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_setxkbmap () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sh () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_shasum () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_showmount () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_shred () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_shuf () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_shutdown () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_signals () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_signify () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sisu () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_slabtop () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_slrn () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_smartmontools () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_smit () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_snoop () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_socket () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sockstat () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_softwareupdate () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sort () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_source () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_spamassassin () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_split () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sqlite () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sqsh () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ss () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ssh () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ssh_hosts () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sshfs () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_starship () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_stat () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_stdbuf () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_stgit () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_store_cache () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_stow () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_strace () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_strftime () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_strings () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_strip () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_stty () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_su () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sub_commands () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sublimetext () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_subscript () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_subversion () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sudo () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_suffix_alias_files () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_surfraw () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_svcadm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_svccfg () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_svcprop () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_svcs () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_svcs_fmri () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_svn-buildpackage () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sw_vers () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_swaks () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_swanctl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_swift () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sys_calls () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sysclean () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sysctl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sysmerge () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_syspatch () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sysrc () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sysstat () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_systat () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_system_profiler () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_sysupgrade () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tac () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tags () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tail () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tar () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tar_archive () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tardy () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tcpdump () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tcpsys () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tcptraceroute () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tee () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_telnet () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_terminals () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tex () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_texi () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_texinfo () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tidy () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tiff () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tilde () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tilde_files () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_time_zone () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_timeout () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tin () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tla () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tldr () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_tload () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tmux () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tmuxinator () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_todo.sh () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_toilet () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_toolchain-source () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_top () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_topgit () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_totd () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_touch () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tpb () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tput () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tr () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tracepath () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_transmission () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_trap () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_trash () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tree () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_truncate () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_truss () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tty () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ttyctl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ttys () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_tune2fs () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_twidge () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_twisted () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_typeset () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ulimit () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_uml () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_umountable () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_unace () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_uname () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_unexpand () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_unhash () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_uniq () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_unison () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_units () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_unshare () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_update-alternatives () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_update-rc.d () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_uptime () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_urls () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_urpmi () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_urxvt () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_usbconfig () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_uscan () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_user_admin () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_user_at_host () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_user_expand () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_user_math_func () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_users () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_users_on () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_uv () {
	typeset -A opt_args
	typeset -a _arguments_options
	local ret=1 
	if is-at-least 5.2
	then
		_arguments_options=(-s -S -C) 
	else
		_arguments_options=(-s -C) 
	fi
	local context curcontext="$curcontext" state line 
	_arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '-V[Display the uv version]' '--version[Display the uv version]' ":: :_uv_commands" "*::: :->uv" && ret=0 
	case $state in
		(uv) words=($line[1] "${words[@]}") 
			(( CURRENT += 1 ))
			curcontext="${curcontext%:*:*}:uv-command-$line[1]:" 
			case $line[1] in
				(run) _arguments "${_arguments_options[@]}" : '(--all-extras)*--extra=[Include optional dependencies from the specified extra name]:EXTRA:_default' '*--no-extra=[Exclude the specified optional dependencies, if \`--all-extras\` is supplied]:NO_EXTRA:_default' '(--only-group --only-dev)*--group=[Include dependencies from the specified dependency group]:GROUP:_default' '*--no-group=[Disable the specified dependency group]:NO_GROUP:_default' '(--group --dev --all-groups)*--only-group=[Only include dependencies from the specified dependency group]:ONLY_GROUP:_default' '*--env-file=[Load environment variables from a \`.env\` file]:ENV_FILE:_files' '*-w+[Run with the given packages installed]:WITH:_default' '*--with=[Run with the given packages installed]:WITH:_default' '*--with-editable=[Run with the given packages installed in editable mode]:WITH_EDITABLE:_default' '*--with-requirements=[Run with all packages listed in the given \`requirements.txt\` files]:WITH_REQUIREMENTS:_default' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' '--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' '--fork-strategy=[The strategy to use when selecting multiple versions of a given package across Python versions and platforms]:FORK_STRATEGY:((fewest\:"Optimize for selecting the fewest number of versions for each package. Older versions may be preferred if they are compatible with a wider range of supported Python versions or platforms"
requires-python\:"Optimize for selecting latest supported version of each package, for each supported Python version"))' '*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-settings-package=[Settings to pass to the PEP 517 build backend for a specific package, specified as \`PACKAGE\:KEY=VALUE\` pairs]:CONFIG_SETTINGS_PACKAGE:_default' '*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE:_default' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for specific packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE:_default' '*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE:_default' '*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE:_default' '(--all-packages)--package=[Run the command in a specific package in the workspace]:PACKAGE:_default' '-p+[The Python interpreter to use for the run environment.]:PYTHON:_default' '--python=[The Python interpreter to use for the run environment.]:PYTHON:_default' '--max-recursion-depth=[Number of times that \`uv run\` will allow recursive invocations]:MAX_RECURSION_DEPTH:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '(--extra)--all-extras[Include all optional dependencies]' '--no-all-extras[]' '--dev[Include the development dependency group]' '--no-dev[Disable the development dependency group]' '--no-default-groups[Ignore the default dependency groups]' '(--only-group --only-dev)--all-groups[Include dependencies from all dependency groups]' '(-s --script --gui-script)-m[Run a Python module]' '(-s --script --gui-script)--module[Run a Python module]' '(--group --all-groups --no-dev)--only-dev[Only include the development dependency group]' '--no-editable[Install any editable dependencies, including the project and any workspace members, as non-editable]' '--inexact[Do not remove extraneous packages present in the environment]' '--exact[Perform an exact sync, removing extraneous packages]' '--no-env-file[Avoid reading environment variables from a \`.env\` file]' '--isolated[Run the command in an isolated virtual environment]' '--active[Prefer the active virtual environment over the project'\''s virtual environment]' '--no-active[Prefer project'\''s virtual environment over an active environment]' '--no-sync[Avoid syncing the virtual environment]' '(--frozen -U --upgrade)--locked[Assert that the \`uv.lock\` will remain unchanged]' '(--locked -U --upgrade --no-sources)--frozen[Run without updating the \`uv.lock\` file]' '(-m --module --gui-script)-s[Run the given path as a Python script]' '(-m --module --gui-script)--script[Run the given path as a Python script]' '(-s --script -m --module)--gui-script[Run the given path as a Python GUI script]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--no-upgrade[]' '--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' '--no-reinstall[]' '--pre[]' '--no-build-isolation[Disable isolation when building source distributions]' '--build-isolation[]' '--compile-bytecode[Compile Python files to bytecode after installation]' '--no-compile-bytecode[]' '--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources]' '--no-build[Don'\''t build source distributions]' '--build[]' '--no-binary[Don'\''t install pre-built wheels]' '--binary[]' '(--offline)--refresh[Refresh all cached data]' '(--offline)--no-refresh[]' '(--package)--all-packages[Run the command with all workspace members installed]' '(--package)--no-project[Avoid discovering the project or workspace]' '--show-resolution[Whether to show resolver and installer output from any environment modifications]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' "*::external_command:_default" && ret=0  ;;
				(init) _arguments "${_arguments_options[@]}" : '(--script)--name=[The name of the project]:NAME:_default' '(--script)--description=[Set the project description]:DESCRIPTION:_default' '(--script)--vcs=[Initialize a version control system for the project]:VCS:((git\:"Use Git for version control"
none\:"Do not use any version control system"))' '(--script --no-package)--build-backend=[Initialize a build-backend of choice for the project]:BUILD_BACKEND:((uv\:"Use uv as the project build backend"
hatch\:"Use \[hatchling\](https\://pypi.org/project/hatchling) as the project build backend"
flit\:"Use \[flit-core\](https\://pypi.org/project/flit-core) as the project build backend"
pdm\:"Use \[pdm-backend\](https\://pypi.org/project/pdm-backend) as the project build backend"
poetry\:"Use \[poetry-core\](https\://pypi.org/project/poetry-core) as the project build backend"
setuptools\:"Use \[setuptools\](https\://pypi.org/project/setuptools) as the project build backend"
maturin\:"Use \[maturin\](https\://pypi.org/project/maturin) as the project build backend"
scikit\:"Use \[scikit-build-core\](https\://pypi.org/project/scikit-build-core) as the project build backend"))' '--author-from=[Fill in the \`authors\` field in the \`pyproject.toml\`]:AUTHOR_FROM:((auto\:"Fetch the author information from some sources (e.g., Git) automatically"
git\:"Fetch the author information from Git configuration only"
none\:"Do not infer the author information"))' '-p+[The Python interpreter to use to determine the minimum supported Python version.]:PYTHON:_default' '--python=[The Python interpreter to use to determine the minimum supported Python version.]:PYTHON:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '(--script)--bare[Only create a \`pyproject.toml\`]' '(--package)--virtual[Create a virtual project, rather than a package]' '--package[Set up the project to be built as a Python package]' '(--lib --build-backend)--no-package[Do not set up the project to be built as a Python package]' '(--lib --script)--app[Create a project for an application]' '(--app --script)--lib[Create a project for a library]' '(--app --lib --package --build-backend --description)--script[Create a script]' '(--script)--no-description[Disable the description for the project]' '--backend[Invalid option name for build backend]' '--no-readme[Do not create a \`README.md\` file]' '--no-pin-python[Do not create a \`.python-version\` file for the project]' '--pin-python[Create a \`.python-version\` file for the project]' '--no-workspace[Avoid discovering a workspace and create a standalone project]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '::path -- The path to use for the project/script:_files' && ret=0  ;;
				(add) _arguments "${_arguments_options[@]}" : '*-r+[Add all packages listed in the given \`requirements.txt\` files]:REQUIREMENTS:_files' '*--requirements=[Add all packages listed in the given \`requirements.txt\` files]:REQUIREMENTS:_files' '*-c+[Constrain versions using the given requirements files]:CONSTRAINTS:_default' '*--constraints=[Constrain versions using the given requirements files]:CONSTRAINTS:_default' '-m+[Apply this marker to all added packages]:MARKER:_default' '--marker=[Apply this marker to all added packages]:MARKER:_default' '(--dev --group)--optional=[Add the requirements to the package'\''s optional dependencies for the specified extra]:OPTIONAL:_default' '(--dev --optional --script)--group=[Add the requirements to the specified dependency group]:GROUP:_default' '--bounds=[The kind of version specifier to use when adding dependencies]:BOUNDS:((lower\:"Only a lower bound, e.g., \`>=1.2.3\`"
major\:"Allow the same major version, similar to the semver caret, e.g., \`>=1.2.3, <2.0.0\`"
minor\:"Allow the same minor version, similar to the semver tilde, e.g., \`>=1.2.3, <1.3.0\`"
exact\:"Pin the exact version, e.g., \`==1.2.3\`"))' '--rev=[Commit to use when adding a dependency from Git]:REV:_default' '--tag=[Tag to use when adding a dependency from Git]:TAG:_default' '--branch=[Branch to use when adding a dependency from Git]:BRANCH:_default' '*--extra=[Extras to enable for the dependency]:EXTRA:_default' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' '--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' '--fork-strategy=[The strategy to use when selecting multiple versions of a given package across Python versions and platforms]:FORK_STRATEGY:((fewest\:"Optimize for selecting the fewest number of versions for each package. Older versions may be preferred if they are compatible with a wider range of supported Python versions or platforms"
requires-python\:"Optimize for selecting latest supported version of each package, for each supported Python version"))' '*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-settings-package=[Settings to pass to the PEP 517 build backend for a specific package, specified as \`PACKAGE\:KEY=VALUE\` pairs]:CONFIG_SETTINGS_PACKAGE:_default' '*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE:_default' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for specific packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE:_default' '*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE:_default' '*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE:_default' '(--isolated)--package=[Add the dependency to a specific package in the workspace]:PACKAGE:_default' '(--dev --optional --package --workspace)--script=[Add the dependency to the specified Python script, rather than to a project]:SCRIPT:_files' '-p+[The Python interpreter to use for resolving and syncing.]:PYTHON:_default' '--python=[The Python interpreter to use for resolving and syncing.]:PYTHON:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '(--optional --group --script)--dev[Add the requirements to the development dependency group]' '--editable[Add the requirements as editable]' '--no-editable[]' '(--editable --no-editable --rev --tag --branch)--raw[Add a dependency as provided]' '(--frozen)--no-sync[Avoid syncing the virtual environment]' '(--frozen -U --upgrade)--locked[Assert that the \`uv.lock\` will remain unchanged]' '(--locked -U --upgrade --no-sources)--frozen[Add dependencies without re-locking the project]' '--active[Prefer the active virtual environment over the project'\''s virtual environment]' '--no-active[Prefer project'\''s virtual environment over an active environment]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--no-upgrade[]' '--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' '--no-reinstall[]' '--pre[]' '--no-build-isolation[Disable isolation when building source distributions]' '--build-isolation[]' '--compile-bytecode[Compile Python files to bytecode after installation]' '--no-compile-bytecode[]' '--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources]' '--no-build[Don'\''t build source distributions]' '--build[]' '--no-binary[Don'\''t install pre-built wheels]' '--binary[]' '(--offline)--refresh[Refresh all cached data]' '(--offline)--no-refresh[]' '--workspace[Add the dependency as a workspace member]' '--no-workspace[Don'\''t add the dependency as a workspace member]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '*::packages -- The packages to add, as PEP 508 requirements (e.g., `ruff==0.5.0`):_default' && ret=0  ;;
				(remove) _arguments "${_arguments_options[@]}" : '(--dev --group --script)--optional=[Remove the packages from the project'\''s optional dependencies for the specified extra]:OPTIONAL:_default' '(--dev --optional --script)--group=[Remove the packages from the specified dependency group]:GROUP:_default' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' '--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' '--fork-strategy=[The strategy to use when selecting multiple versions of a given package across Python versions and platforms]:FORK_STRATEGY:((fewest\:"Optimize for selecting the fewest number of versions for each package. Older versions may be preferred if they are compatible with a wider range of supported Python versions or platforms"
requires-python\:"Optimize for selecting latest supported version of each package, for each supported Python version"))' '*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-settings-package=[Settings to pass to the PEP 517 build backend for a specific package, specified as \`PACKAGE\:KEY=VALUE\` pairs]:CONFIG_SETTINGS_PACKAGE:_default' '*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE:_default' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for specific packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE:_default' '*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE:_default' '*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE:_default' '(--isolated)--package=[Remove the dependencies from a specific package in the workspace]:PACKAGE:_default' '--script=[Remove the dependency from the specified Python script, rather than from a project]:SCRIPT:_files' '-p+[The Python interpreter to use for resolving and syncing.]:PYTHON:_default' '--python=[The Python interpreter to use for resolving and syncing.]:PYTHON:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '(--optional --group)--dev[Remove the packages from the development dependency group]' '(--frozen)--no-sync[Avoid syncing the virtual environment after re-locking the project]' '--active[Prefer the active virtual environment over the project'\''s virtual environment]' '--no-active[Prefer project'\''s virtual environment over an active environment]' '(--frozen -U --upgrade)--locked[Assert that the \`uv.lock\` will remain unchanged]' '(--locked -U --upgrade --no-sources)--frozen[Remove dependencies without re-locking the project]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--no-upgrade[]' '--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' '--no-reinstall[]' '--pre[]' '--no-build-isolation[Disable isolation when building source distributions]' '--build-isolation[]' '--compile-bytecode[Compile Python files to bytecode after installation]' '--no-compile-bytecode[]' '--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources]' '--no-build[Don'\''t build source distributions]' '--build[]' '--no-binary[Don'\''t install pre-built wheels]' '--binary[]' '(--offline)--refresh[Refresh all cached data]' '(--offline)--no-refresh[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '*::packages -- The names of the dependencies to remove (e.g., `ruff`):_default' && ret=0  ;;
				(version) _arguments "${_arguments_options[@]}" : '*--bump=[Update the project version using the given semantics]:BUMP:((major\:"Increase the major version (e.g., 1.2.3 => 2.0.0)"
minor\:"Increase the minor version (e.g., 1.2.3 => 1.3.0)"
patch\:"Increase the patch version (e.g., 1.2.3 => 1.2.4)"
stable\:"Move from a pre-release to stable version (e.g., 1.2.3b4.post5.dev6 => 1.2.3)"
alpha\:"Increase the alpha version (e.g., 1.2.3a4 => 1.2.3a5)"
beta\:"Increase the beta version (e.g., 1.2.3b4 => 1.2.3b5)"
rc\:"Increase the rc version (e.g., 1.2.3rc4 => 1.2.3rc5)"
post\:"Increase the post version (e.g., 1.2.3.post5 => 1.2.3.post6)"
dev\:"Increase the dev version (e.g., 1.2.3a4.dev6 => 1.2.3.dev7)"))' '--output-format=[The format of the output]:OUTPUT_FORMAT:((text\:"Display the version as plain text"
json\:"Display the version as JSON"))' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' '--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' '--fork-strategy=[The strategy to use when selecting multiple versions of a given package across Python versions and platforms]:FORK_STRATEGY:((fewest\:"Optimize for selecting the fewest number of versions for each package. Older versions may be preferred if they are compatible with a wider range of supported Python versions or platforms"
requires-python\:"Optimize for selecting latest supported version of each package, for each supported Python version"))' '*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-settings-package=[Settings to pass to the PEP 517 build backend for a specific package, specified as \`PACKAGE\:KEY=VALUE\` pairs]:CONFIG_SETTINGS_PACKAGE:_default' '*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE:_default' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for specific packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE:_default' '*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE:_default' '*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE:_default' '(--isolated)--package=[Update the version of a specific package in the workspace]:PACKAGE:_default' '-p+[The Python interpreter to use for resolving and syncing.]:PYTHON:_default' '--python=[The Python interpreter to use for resolving and syncing.]:PYTHON:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--dry-run[Don'\''t write a new version to the \`pyproject.toml\`]' '--short[Only show the version]' '(--frozen)--no-sync[Avoid syncing the virtual environment after re-locking the project]' '--active[Prefer the active virtual environment over the project'\''s virtual environment]' '--no-active[Prefer project'\''s virtual environment over an active environment]' '(--frozen -U --upgrade)--locked[Assert that the \`uv.lock\` will remain unchanged]' '(--locked -U --upgrade --no-sources)--frozen[Update the version without re-locking the project]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--no-upgrade[]' '--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' '--no-reinstall[]' '--pre[]' '--no-build-isolation[Disable isolation when building source distributions]' '--build-isolation[]' '--compile-bytecode[Compile Python files to bytecode after installation]' '--no-compile-bytecode[]' '--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources]' '--no-build[Don'\''t build source distributions]' '--build[]' '--no-binary[Don'\''t install pre-built wheels]' '--binary[]' '(--offline)--refresh[Refresh all cached data]' '(--offline)--no-refresh[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '::value -- Set the project version to this value:_default' && ret=0  ;;
				(sync) _arguments "${_arguments_options[@]}" : '(--all-extras)*--extra=[Include optional dependencies from the specified extra name]:EXTRA:_default' '--output-format=[Select the output format]:OUTPUT_FORMAT:((text\:"Display the result in a human-readable format"
json\:"Display the result in JSON format"))' '*--no-extra=[Exclude the specified optional dependencies, if \`--all-extras\` is supplied]:NO_EXTRA:_default' '(--only-group --only-dev)*--group=[Include dependencies from the specified dependency group]:GROUP:_default' '*--no-group=[Disable the specified dependency group]:NO_GROUP:_default' '(--group --dev --all-groups)*--only-group=[Only include dependencies from the specified dependency group]:ONLY_GROUP:_default' '*--no-install-package=[Do not install the given package(s)]:NO_INSTALL_PACKAGE:_default' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' '--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' '--fork-strategy=[The strategy to use when selecting multiple versions of a given package across Python versions and platforms]:FORK_STRATEGY:((fewest\:"Optimize for selecting the fewest number of versions for each package. Older versions may be preferred if they are compatible with a wider range of supported Python versions or platforms"
requires-python\:"Optimize for selecting latest supported version of each package, for each supported Python version"))' '*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-settings-package=[Settings to pass to the PEP 517 build backend for a specific package, specified as \`PACKAGE\:KEY=VALUE\` pairs]:CONFIG_SETTINGS_PACKAGE:_default' '*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE:_default' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for specific packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE:_default' '*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE:_default' '*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE:_default' '(--all-packages)--package=[Sync for a specific package in the workspace]:PACKAGE:_default' '(--all-packages --package --no-install-project --no-install-workspace --extra --all-extras --no-extra --no-all-extras --dev --no-dev --only-dev --group --no-group --no-default-groups --only-group --all-groups)--script=[Sync the environment for a Python script, rather than the current project]:SCRIPT:_files' '-p+[The Python interpreter to use for the project environment.]:PYTHON:_default' '--python=[The Python interpreter to use for the project environment.]:PYTHON:_default' '--python-platform=[The platform for which requirements should be installed]:PYTHON_PLATFORM:((windows\:"An alias for \`x86_64-pc-windows-msvc\`, the default target for Windows"
linux\:"An alias for \`x86_64-unknown-linux-gnu\`, the default target for Linux"
macos\:"An alias for \`aarch64-apple-darwin\`, the default target for macOS"
x86_64-pc-windows-msvc\:"A 64-bit x86 Windows target"
i686-pc-windows-msvc\:"A 32-bit x86 Windows target"
x86_64-unknown-linux-gnu\:"An x86 Linux target. Equivalent to \`x86_64-manylinux_2_28\`"
aarch64-apple-darwin\:"An ARM-based macOS target, as seen on Apple Silicon devices"
x86_64-apple-darwin\:"An x86 macOS target"
aarch64-unknown-linux-gnu\:"An ARM64 Linux target. Equivalent to \`aarch64-manylinux_2_28\`"
aarch64-unknown-linux-musl\:"An ARM64 Linux target"
x86_64-unknown-linux-musl\:"An \`x86_64\` Linux target"
x86_64-manylinux2014\:"An \`x86_64\` target for the \`manylinux2014\` platform. Equivalent to \`x86_64-manylinux_2_17\`"
x86_64-manylinux_2_17\:"An \`x86_64\` target for the \`manylinux_2_17\` platform"
x86_64-manylinux_2_28\:"An \`x86_64\` target for the \`manylinux_2_28\` platform"
x86_64-manylinux_2_31\:"An \`x86_64\` target for the \`manylinux_2_31\` platform"
x86_64-manylinux_2_32\:"An \`x86_64\` target for the \`manylinux_2_32\` platform"
x86_64-manylinux_2_33\:"An \`x86_64\` target for the \`manylinux_2_33\` platform"
x86_64-manylinux_2_34\:"An \`x86_64\` target for the \`manylinux_2_34\` platform"
x86_64-manylinux_2_35\:"An \`x86_64\` target for the \`manylinux_2_35\` platform"
x86_64-manylinux_2_36\:"An \`x86_64\` target for the \`manylinux_2_36\` platform"
x86_64-manylinux_2_37\:"An \`x86_64\` target for the \`manylinux_2_37\` platform"
x86_64-manylinux_2_38\:"An \`x86_64\` target for the \`manylinux_2_38\` platform"
x86_64-manylinux_2_39\:"An \`x86_64\` target for the \`manylinux_2_39\` platform"
x86_64-manylinux_2_40\:"An \`x86_64\` target for the \`manylinux_2_40\` platform"
aarch64-manylinux2014\:"An ARM64 target for the \`manylinux2014\` platform. Equivalent to \`aarch64-manylinux_2_17\`"
aarch64-manylinux_2_17\:"An ARM64 target for the \`manylinux_2_17\` platform"
aarch64-manylinux_2_28\:"An ARM64 target for the \`manylinux_2_28\` platform"
aarch64-manylinux_2_31\:"An ARM64 target for the \`manylinux_2_31\` platform"
aarch64-manylinux_2_32\:"An ARM64 target for the \`manylinux_2_32\` platform"
aarch64-manylinux_2_33\:"An ARM64 target for the \`manylinux_2_33\` platform"
aarch64-manylinux_2_34\:"An ARM64 target for the \`manylinux_2_34\` platform"
aarch64-manylinux_2_35\:"An ARM64 target for the \`manylinux_2_35\` platform"
aarch64-manylinux_2_36\:"An ARM64 target for the \`manylinux_2_36\` platform"
aarch64-manylinux_2_37\:"An ARM64 target for the \`manylinux_2_37\` platform"
aarch64-manylinux_2_38\:"An ARM64 target for the \`manylinux_2_38\` platform"
aarch64-manylinux_2_39\:"An ARM64 target for the \`manylinux_2_39\` platform"
aarch64-manylinux_2_40\:"An ARM64 target for the \`manylinux_2_40\` platform"
wasm32-pyodide2024\:"A wasm32 target using the Pyodide 2024 platform. Meant for use with Python 3.12"))' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '(--extra)--all-extras[Include all optional dependencies]' '--no-all-extras[]' '--dev[Include the development dependency group]' '--no-dev[Disable the development dependency group]' '(--group --all-groups --no-dev)--only-dev[Only include the development dependency group]' '--no-default-groups[Ignore the default dependency groups]' '(--only-group --only-dev)--all-groups[Include dependencies from all dependency groups]' '--no-editable[Install any editable dependencies, including the project and any workspace members, as non-editable]' '--inexact[Do not remove extraneous packages present in the environment]' '--exact[Perform an exact sync, removing extraneous packages]' '--active[Sync dependencies to the active virtual environment]' '--no-active[Prefer project'\''s virtual environment over an active environment]' '--no-install-project[Do not install the current project]' '--no-install-workspace[Do not install any workspace members, including the root project]' '(--frozen -U --upgrade)--locked[Assert that the \`uv.lock\` will remain unchanged]' '(--locked -U --upgrade --no-sources)--frozen[Sync without updating the \`uv.lock\` file]' '--dry-run[Perform a dry run, without writing the lockfile or modifying the project environment]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--no-upgrade[]' '--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' '--no-reinstall[]' '--pre[]' '--no-build-isolation[Disable isolation when building source distributions]' '--build-isolation[]' '--compile-bytecode[Compile Python files to bytecode after installation]' '--no-compile-bytecode[]' '--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources]' '--no-build[Don'\''t build source distributions]' '--build[]' '--no-binary[Don'\''t install pre-built wheels]' '--binary[]' '(--offline)--refresh[Refresh all cached data]' '(--offline)--no-refresh[]' '(--package)--all-packages[Sync all packages in the workspace]' '--check[Check if the Python environment is synchronized with the project]' '--no-check[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
				(lock) _arguments "${_arguments_options[@]}" : '--script=[Lock the specified Python script, rather than the current project]:SCRIPT:_files' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' '--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' '--fork-strategy=[The strategy to use when selecting multiple versions of a given package across Python versions and platforms]:FORK_STRATEGY:((fewest\:"Optimize for selecting the fewest number of versions for each package. Older versions may be preferred if they are compatible with a wider range of supported Python versions or platforms"
requires-python\:"Optimize for selecting latest supported version of each package, for each supported Python version"))' '*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-settings-package=[Settings to pass to the PEP 517 build backend for a specific package, specified as \`PACKAGE\:KEY=VALUE\` pairs]:CONFIG_SETTINGS_PACKAGE:_default' '*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE:_default' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for a specific package to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE:_default' '*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE:_default' '*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE:_default' '-p+[The Python interpreter to use during resolution.]:PYTHON:_default' '--python=[The Python interpreter to use during resolution.]:PYTHON:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '(--check-exists -U --upgrade)--check[Check if the lockfile is up-to-date]' '(--check)--check-exists[Assert that a \`uv.lock\` exists without checking if it is up-to-date]' '(--check-exists --check)--dry-run[Perform a dry run, without writing the lockfile]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--no-upgrade[]' '--pre[]' '--no-build-isolation[Disable isolation when building source distributions]' '--build-isolation[]' '--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources]' '--no-build[Don'\''t build source distributions]' '--build[]' '--no-binary[Don'\''t install pre-built wheels]' '--binary[]' '(--offline)--refresh[Refresh all cached data]' '(--offline)--no-refresh[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
				(export) _arguments "${_arguments_options[@]}" : '--format=[The format to which \`uv.lock\` should be exported]:FORMAT:((requirements.txt\:"Export in \`requirements.txt\` format"
pylock.toml\:"Export in \`pylock.toml\` format"))' '(--all-packages)--package=[Export the dependencies for a specific package in the workspace]:PACKAGE:_default' '(--all-packages)*--prune=[Prune the given package from the dependency tree]:PACKAGE:_default' '(--all-extras)*--extra=[Include optional dependencies from the specified extra name]:EXTRA:_default' '*--no-extra=[Exclude the specified optional dependencies, if \`--all-extras\` is supplied]:NO_EXTRA:_default' '(--only-group --only-dev)*--group=[Include dependencies from the specified dependency group]:GROUP:_default' '*--no-group=[Disable the specified dependency group]:NO_GROUP:_default' '(--group --dev --all-groups)*--only-group=[Only include dependencies from the specified dependency group]:ONLY_GROUP:_default' '-o+[Write the exported requirements to the given file]:OUTPUT_FILE:_files' '--output-file=[Write the exported requirements to the given file]:OUTPUT_FILE:_files' '*--no-emit-package=[Do not emit the given package(s)]:NO_EMIT_PACKAGE:_default' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' '--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' '--fork-strategy=[The strategy to use when selecting multiple versions of a given package across Python versions and platforms]:FORK_STRATEGY:((fewest\:"Optimize for selecting the fewest number of versions for each package. Older versions may be preferred if they are compatible with a wider range of supported Python versions or platforms"
requires-python\:"Optimize for selecting latest supported version of each package, for each supported Python version"))' '*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-settings-package=[Settings to pass to the PEP 517 build backend for a specific package, specified as \`PACKAGE\:KEY=VALUE\` pairs]:CONFIG_SETTINGS_PACKAGE:_default' '*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE:_default' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for a specific package to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE:_default' '*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE:_default' '*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE:_default' '(--all-packages --package --no-emit-project --no-emit-workspace)--script=[Export the dependencies for the specified PEP 723 Python script, rather than the current project]:SCRIPT:_files' '-p+[The Python interpreter to use during resolution.]:PYTHON:_default' '--python=[The Python interpreter to use during resolution.]:PYTHON:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '(--package)--all-packages[Export the entire workspace]' '(--extra)--all-extras[Include all optional dependencies]' '--no-all-extras[]' '--dev[Include the development dependency group]' '--no-dev[Disable the development dependency group]' '(--group --all-groups --no-dev)--only-dev[Only include the development dependency group]' '--no-default-groups[Ignore the default dependency groups]' '(--only-group --only-dev)--all-groups[Include dependencies from all dependency groups]' '--no-annotate[Exclude comment annotations indicating the source of each package]' '--annotate[]' '--no-header[Exclude the comment header at the top of the generated output file]' '--header[]' '--no-editable[Export any editable dependencies, including the project and any workspace members, as non-editable]' '--hashes[Include hashes for all dependencies]' '--no-hashes[Omit hashes in the generated output]' '--no-emit-project[Do not emit the current project]' '--no-emit-workspace[Do not emit any workspace members, including the root project]' '(--frozen -U --upgrade)--locked[Assert that the \`uv.lock\` will remain unchanged]' '(--locked -U --upgrade --no-sources)--frozen[Do not update the \`uv.lock\` before exporting]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--no-upgrade[]' '--pre[]' '--no-build-isolation[Disable isolation when building source distributions]' '--build-isolation[]' '--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources]' '--no-build[Don'\''t build source distributions]' '--build[]' '--no-binary[Don'\''t install pre-built wheels]' '--binary[]' '(--offline)--refresh[Refresh all cached data]' '(--offline)--no-refresh[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
				(tree) _arguments "${_arguments_options[@]}" : '-d+[Maximum display depth of the dependency tree]:DEPTH:_default' '--depth=[Maximum display depth of the dependency tree]:DEPTH:_default' '*--prune=[Prune the given package from the display of the dependency tree]:PRUNE:_default' '*--package=[Display only the specified packages]:PACKAGE:_default' '(--only-group --only-dev)*--group=[Include dependencies from the specified dependency group]:GROUP:_default' '*--no-group=[Disable the specified dependency group]:NO_GROUP:_default' '(--group --dev --all-groups)*--only-group=[Only include dependencies from the specified dependency group]:ONLY_GROUP:_default' '*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE:_default' '*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE:_default' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' '--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' '--fork-strategy=[The strategy to use when selecting multiple versions of a given package across Python versions and platforms]:FORK_STRATEGY:((fewest\:"Optimize for selecting the fewest number of versions for each package. Older versions may be preferred if they are compatible with a wider range of supported Python versions or platforms"
requires-python\:"Optimize for selecting latest supported version of each package, for each supported Python version"))' '*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-settings-package=[Settings to pass to the PEP 517 build backend for a specific package, specified as \`PACKAGE\:KEY=VALUE\` pairs]:CONFIG_SETTINGS_PACKAGE:_default' '*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE:_default' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for a specific package to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '--script=[Show the dependency tree the specified PEP 723 Python script, rather than the current project]:SCRIPT:_files' '(--universal)--python-version=[The Python version to use when filtering the tree]:PYTHON_VERSION:_default' '(--universal)--python-platform=[The platform to use when filtering the tree]:PYTHON_PLATFORM:((windows\:"An alias for \`x86_64-pc-windows-msvc\`, the default target for Windows"
linux\:"An alias for \`x86_64-unknown-linux-gnu\`, the default target for Linux"
macos\:"An alias for \`aarch64-apple-darwin\`, the default target for macOS"
x86_64-pc-windows-msvc\:"A 64-bit x86 Windows target"
i686-pc-windows-msvc\:"A 32-bit x86 Windows target"
x86_64-unknown-linux-gnu\:"An x86 Linux target. Equivalent to \`x86_64-manylinux_2_28\`"
aarch64-apple-darwin\:"An ARM-based macOS target, as seen on Apple Silicon devices"
x86_64-apple-darwin\:"An x86 macOS target"
aarch64-unknown-linux-gnu\:"An ARM64 Linux target. Equivalent to \`aarch64-manylinux_2_28\`"
aarch64-unknown-linux-musl\:"An ARM64 Linux target"
x86_64-unknown-linux-musl\:"An \`x86_64\` Linux target"
x86_64-manylinux2014\:"An \`x86_64\` target for the \`manylinux2014\` platform. Equivalent to \`x86_64-manylinux_2_17\`"
x86_64-manylinux_2_17\:"An \`x86_64\` target for the \`manylinux_2_17\` platform"
x86_64-manylinux_2_28\:"An \`x86_64\` target for the \`manylinux_2_28\` platform"
x86_64-manylinux_2_31\:"An \`x86_64\` target for the \`manylinux_2_31\` platform"
x86_64-manylinux_2_32\:"An \`x86_64\` target for the \`manylinux_2_32\` platform"
x86_64-manylinux_2_33\:"An \`x86_64\` target for the \`manylinux_2_33\` platform"
x86_64-manylinux_2_34\:"An \`x86_64\` target for the \`manylinux_2_34\` platform"
x86_64-manylinux_2_35\:"An \`x86_64\` target for the \`manylinux_2_35\` platform"
x86_64-manylinux_2_36\:"An \`x86_64\` target for the \`manylinux_2_36\` platform"
x86_64-manylinux_2_37\:"An \`x86_64\` target for the \`manylinux_2_37\` platform"
x86_64-manylinux_2_38\:"An \`x86_64\` target for the \`manylinux_2_38\` platform"
x86_64-manylinux_2_39\:"An \`x86_64\` target for the \`manylinux_2_39\` platform"
x86_64-manylinux_2_40\:"An \`x86_64\` target for the \`manylinux_2_40\` platform"
aarch64-manylinux2014\:"An ARM64 target for the \`manylinux2014\` platform. Equivalent to \`aarch64-manylinux_2_17\`"
aarch64-manylinux_2_17\:"An ARM64 target for the \`manylinux_2_17\` platform"
aarch64-manylinux_2_28\:"An ARM64 target for the \`manylinux_2_28\` platform"
aarch64-manylinux_2_31\:"An ARM64 target for the \`manylinux_2_31\` platform"
aarch64-manylinux_2_32\:"An ARM64 target for the \`manylinux_2_32\` platform"
aarch64-manylinux_2_33\:"An ARM64 target for the \`manylinux_2_33\` platform"
aarch64-manylinux_2_34\:"An ARM64 target for the \`manylinux_2_34\` platform"
aarch64-manylinux_2_35\:"An ARM64 target for the \`manylinux_2_35\` platform"
aarch64-manylinux_2_36\:"An ARM64 target for the \`manylinux_2_36\` platform"
aarch64-manylinux_2_37\:"An ARM64 target for the \`manylinux_2_37\` platform"
aarch64-manylinux_2_38\:"An ARM64 target for the \`manylinux_2_38\` platform"
aarch64-manylinux_2_39\:"An ARM64 target for the \`manylinux_2_39\` platform"
aarch64-manylinux_2_40\:"An ARM64 target for the \`manylinux_2_40\` platform"
wasm32-pyodide2024\:"A wasm32 target using the Pyodide 2024 platform. Meant for use with Python 3.12"))' '-p+[The Python interpreter to use for locking and filtering.]:PYTHON:_default' '--python=[The Python interpreter to use for locking and filtering.]:PYTHON:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--universal[Show a platform-independent dependency tree]' '--no-dedupe[Do not de-duplicate repeated dependencies. Usually, when a package has already displayed its dependencies, further occurrences will not re-display its dependencies, and will include a (*) to indicate it has already been shown. This flag will cause those duplicates to be repeated]' '--invert[Show the reverse dependencies for the given package. This flag will invert the tree and display the packages that depend on the given package]' '--outdated[Show the latest available version of each package in the tree]' '--dev[Include the development dependency group]' '(--group --all-groups --no-dev)--only-dev[Only include the development dependency group]' '--no-dev[Disable the development dependency group]' '--no-default-groups[Ignore the default dependency groups]' '(--only-group --only-dev)--all-groups[Include dependencies from all dependency groups]' '(--frozen -U --upgrade)--locked[Assert that the \`uv.lock\` will remain unchanged]' '(--locked -U --upgrade --no-sources)--frozen[Display the requirements without locking the project]' '--no-build[Don'\''t build source distributions]' '--build[]' '--no-binary[Don'\''t install pre-built wheels]' '--binary[]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--no-upgrade[]' '--pre[]' '--no-build-isolation[Disable isolation when building source distributions]' '--build-isolation[]' '--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
				(tool) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' ":: :_uv__tool_commands" "*::: :->tool" && ret=0 
					case $state in
						(tool) words=($line[1] "${words[@]}") 
							(( CURRENT += 1 ))
							curcontext="${curcontext%:*:*}:uv-tool-command-$line[1]:" 
							case $line[1] in
								(run) _arguments "${_arguments_options[@]}" : '--from=[Use the given package to provide the command]:FROM:_default' '*-w+[Run with the given packages installed]:WITH:_default' '*--with=[Run with the given packages installed]:WITH:_default' '*--with-editable=[Run with the given packages installed in editable mode]:WITH_EDITABLE:_default' '*--with-requirements=[Run with all packages listed in the given \`requirements.txt\` files]:WITH_REQUIREMENTS:_default' '*-c+[Constrain versions using the given requirements files]:CONSTRAINTS:_default' '*--constraints=[Constrain versions using the given requirements files]:CONSTRAINTS:_default' '*-b+[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINTS:_default' '*--build-constraints=[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINTS:_default' '*--overrides=[Override versions using the given requirements files]:OVERRIDES:_default' '*--env-file=[Load environment variables from a \`.env\` file]:ENV_FILE:_files' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' '--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' '--fork-strategy=[The strategy to use when selecting multiple versions of a given package across Python versions and platforms]:FORK_STRATEGY:((fewest\:"Optimize for selecting the fewest number of versions for each package. Older versions may be preferred if they are compatible with a wider range of supported Python versions or platforms"
requires-python\:"Optimize for selecting latest supported version of each package, for each supported Python version"))' '*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-settings-package=[Settings to pass to the PEP 517 build backend for a specific package, specified as \`PACKAGE\:KEY=VALUE\` pairs]:CONFIG_SETTINGS_PACKAGE:_default' '*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE:_default' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for specific packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE:_default' '*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE:_default' '*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE:_default' '-p+[The Python interpreter to use to build the run environment.]:PYTHON:_default' '--python=[The Python interpreter to use to build the run environment.]:PYTHON:_default' '--generate-shell-completion=[]:GENERATE_SHELL_COMPLETION:(bash elvish fish nushell powershell zsh)' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--isolated[Run the tool in an isolated virtual environment, ignoring any already-installed tools]' '--no-env-file[Avoid reading environment variables from a \`.env\` file]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--no-upgrade[]' '--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' '--no-reinstall[]' '--pre[]' '--no-build-isolation[Disable isolation when building source distributions]' '--build-isolation[]' '--compile-bytecode[Compile Python files to bytecode after installation]' '--no-compile-bytecode[]' '--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources]' '--no-build[Don'\''t build source distributions]' '--build[]' '--no-binary[Don'\''t install pre-built wheels]' '--binary[]' '(--offline)--refresh[Refresh all cached data]' '(--offline)--no-refresh[]' '--show-resolution[Whether to show resolver and installer output from any environment modifications]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' "*::external_command:_default" && ret=0  ;;
								(uvx) _arguments "${_arguments_options[@]}" : '--from=[Use the given package to provide the command]:FROM:_default' '*-w+[Run with the given packages installed]:WITH:_default' '*--with=[Run with the given packages installed]:WITH:_default' '*--with-editable=[Run with the given packages installed in editable mode]:WITH_EDITABLE:_default' '*--with-requirements=[Run with all packages listed in the given \`requirements.txt\` files]:WITH_REQUIREMENTS:_default' '*-c+[Constrain versions using the given requirements files]:CONSTRAINTS:_default' '*--constraints=[Constrain versions using the given requirements files]:CONSTRAINTS:_default' '*-b+[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINTS:_default' '*--build-constraints=[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINTS:_default' '*--overrides=[Override versions using the given requirements files]:OVERRIDES:_default' '*--env-file=[Load environment variables from a \`.env\` file]:ENV_FILE:_files' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' '--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' '--fork-strategy=[The strategy to use when selecting multiple versions of a given package across Python versions and platforms]:FORK_STRATEGY:((fewest\:"Optimize for selecting the fewest number of versions for each package. Older versions may be preferred if they are compatible with a wider range of supported Python versions or platforms"
requires-python\:"Optimize for selecting latest supported version of each package, for each supported Python version"))' '*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-settings-package=[Settings to pass to the PEP 517 build backend for a specific package, specified as \`PACKAGE\:KEY=VALUE\` pairs]:CONFIG_SETTINGS_PACKAGE:_default' '*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE:_default' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for specific packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE:_default' '*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE:_default' '*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE:_default' '-p+[The Python interpreter to use to build the run environment.]:PYTHON:_default' '--python=[The Python interpreter to use to build the run environment.]:PYTHON:_default' '--generate-shell-completion=[]:GENERATE_SHELL_COMPLETION:(bash elvish fish nushell powershell zsh)' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--isolated[Run the tool in an isolated virtual environment, ignoring any already-installed tools]' '--no-env-file[Avoid reading environment variables from a \`.env\` file]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--no-upgrade[]' '--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' '--no-reinstall[]' '--pre[]' '--no-build-isolation[Disable isolation when building source distributions]' '--build-isolation[]' '--compile-bytecode[Compile Python files to bytecode after installation]' '--no-compile-bytecode[]' '--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources]' '--no-build[Don'\''t build source distributions]' '--build[]' '--no-binary[Don'\''t install pre-built wheels]' '--binary[]' '(--offline)--refresh[Refresh all cached data]' '(--offline)--no-refresh[]' '--show-resolution[Whether to show resolver and installer output from any environment modifications]' '-V[Display the uvx version]' '--version[Display the uvx version]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' "*::external_command:_default" && ret=0  ;;
								(install) _arguments "${_arguments_options[@]}" : '--from=[The package to install commands from]:FROM:_default' '*-w+[Include the following additional requirements]:WITH:_default' '*--with=[Include the following additional requirements]:WITH:_default' '*--with-requirements=[Include all requirements listed in the given \`requirements.txt\` files]:WITH_REQUIREMENTS:_default' '*--with-editable=[Include the given packages in editable mode]:WITH_EDITABLE:_default' '*--with-executables-from=[Install executables from the following packages]:WITH_EXECUTABLES_FROM:_default' '*-c+[Constrain versions using the given requirements files]:CONSTRAINTS:_default' '*--constraints=[Constrain versions using the given requirements files]:CONSTRAINTS:_default' '*--overrides=[Override versions using the given requirements files]:OVERRIDES:_default' '*-b+[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINTS:_default' '*--build-constraints=[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINTS:_default' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' '--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' '--fork-strategy=[The strategy to use when selecting multiple versions of a given package across Python versions and platforms]:FORK_STRATEGY:((fewest\:"Optimize for selecting the fewest number of versions for each package. Older versions may be preferred if they are compatible with a wider range of supported Python versions or platforms"
requires-python\:"Optimize for selecting latest supported version of each package, for each supported Python version"))' '*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-settings-package=[Settings to pass to the PEP 517 build backend for a specific package, specified as \`PACKAGE\:KEY=VALUE\` pairs]:CONFIG_SETTINGS_PACKAGE:_default' '*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE:_default' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for specific packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE:_default' '*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE:_default' '*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE:_default' '-p+[The Python interpreter to use to build the tool environment.]:PYTHON:_default' '--python=[The Python interpreter to use to build the tool environment.]:PYTHON:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-e[Install the target package in editable mode, such that changes in the package'\''s source directory are reflected without reinstallation]' '--editable[Install the target package in editable mode, such that changes in the package'\''s source directory are reflected without reinstallation]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--no-upgrade[]' '--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' '--no-reinstall[]' '--pre[]' '--no-build-isolation[Disable isolation when building source distributions]' '--build-isolation[]' '--compile-bytecode[Compile Python files to bytecode after installation]' '--no-compile-bytecode[]' '--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources]' '--no-build[Don'\''t build source distributions]' '--build[]' '--no-binary[Don'\''t install pre-built wheels]' '--binary[]' '(--offline)--refresh[Refresh all cached data]' '(--offline)--no-refresh[]' '--force[Force installation of the tool]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' ':package -- The package to install commands from:_default' && ret=0  ;;
								(upgrade) _arguments "${_arguments_options[@]}" : '-p+[Upgrade a tool, and specify it to use the given Python interpreter to build its environment. Use with \`--all\` to apply to all tools.]:PYTHON:_default' '--python=[Upgrade a tool, and specify it to use the given Python interpreter to build its environment. Use with \`--all\` to apply to all tools.]:PYTHON:_default' '*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' '--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' '--fork-strategy=[The strategy to use when selecting multiple versions of a given package across Python versions and platforms]:FORK_STRATEGY:((fewest\:"Optimize for selecting the fewest number of versions for each package. Older versions may be preferred if they are compatible with a wider range of supported Python versions or platforms"
requires-python\:"Optimize for selecting latest supported version of each package, for each supported Python version"))' '*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting-package=[Settings to pass to the PEP 517 build backend for a specific package, specified as \`PACKAGE\:KEY=VALUE\` pairs]:CONFIG_SETTING_PACKAGE:_default' '*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE:_default' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for specific packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE:_default' '*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '()--all[Upgrade all tools]' '-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' '--no-reinstall[]' '--pre[]' '--no-build-isolation[Disable isolation when building source distributions]' '--build-isolation[]' '--compile-bytecode[Compile Python files to bytecode after installation]' '--no-compile-bytecode[]' '--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources]' '--no-build[Don'\''t build source distributions]' '--build[]' '--no-binary[Don'\''t install pre-built wheels]' '--binary[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '*::name -- The name of the tool to upgrade, along with an optional version specifier:_default' && ret=0  ;;
								(list) _arguments "${_arguments_options[@]}" : '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--show-paths[Whether to display the path to each tool environment and installed executable]' '--show-version-specifiers[Whether to display the version specifier(s) used to install each tool]' '--show-with[Whether to display the additional requirements installed with each tool]' '--show-extras[Whether to display the extra requirements installed with each tool]' '--no-python-downloads[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
								(uninstall) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '()--all[Uninstall all tools]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '*::name -- The name of the tool to uninstall:_default' && ret=0  ;;
								(update-shell) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
								(dir) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--bin[Show the directory into which \`uv tool\` will install executables.]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
							esac ;;
					esac ;;
				(python) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' ":: :_uv__python_commands" "*::: :->python" && ret=0 
					case $state in
						(python) words=($line[1] "${words[@]}") 
							(( CURRENT += 1 ))
							curcontext="${curcontext%:*:*}:uv-python-command-$line[1]:" 
							case $line[1] in
								(list) _arguments "${_arguments_options[@]}" : '--output-format=[Select the output format]:OUTPUT_FORMAT:((text\:"Plain text (for humans)"
json\:"JSON (for computers)"))' '--python-downloads-json-url=[URL pointing to JSON of custom Python installations]:PYTHON_DOWNLOADS_JSON_URL:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--all-versions[List all Python versions, including old patch versions]' '--all-platforms[List Python downloads for all platforms]' '--all-arches[List Python downloads for all architectures]' '(--only-downloads)--only-installed[Only show installed Python versions]' '(--only-installed)--only-downloads[Only show available Python downloads]' '--show-urls[Show the URLs of available Python downloads]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '::request -- A Python request to filter by:_default' && ret=0  ;;
								(install) _arguments "${_arguments_options[@]}" : '-i+[The directory to store the Python installation in]:INSTALL_DIR:_files' '--install-dir=[The directory to store the Python installation in]:INSTALL_DIR:_files' '--mirror=[Set the URL to use as the source for downloading Python installations]:MIRROR:_default' '--pypy-mirror=[Set the URL to use as the source for downloading PyPy installations]:PYPY_MIRROR:_default' '--python-downloads-json-url=[URL pointing to JSON of custom Python installations]:PYTHON_DOWNLOADS_JSON_URL:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--bin[Install a Python executable into the \`bin\` directory]' '(--default)--no-bin[Do not install a Python executable into the \`bin\` directory]' '--registry[Register the Python installation in the Windows registry]' '--no-registry[Do not register the Python installation in the Windows registry]' '-r[Reinstall the requested Python version, if it'\''s already installed]' '--reinstall[Reinstall the requested Python version, if it'\''s already installed]' '-f[Replace existing Python executables during installation]' '--force[Replace existing Python executables during installation]' '(--no-bin)--default[Use as the default Python version]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '*::targets -- The Python version(s) to install:_default' && ret=0  ;;
								(upgrade) _arguments "${_arguments_options[@]}" : '-i+[The directory Python installations are stored in]:INSTALL_DIR:_files' '--install-dir=[The directory Python installations are stored in]:INSTALL_DIR:_files' '--mirror=[Set the URL to use as the source for downloading Python installations]:MIRROR:_default' '--pypy-mirror=[Set the URL to use as the source for downloading PyPy installations]:PYPY_MIRROR:_default' '--python-downloads-json-url=[URL pointing to JSON of custom Python installations]:PYTHON_DOWNLOADS_JSON_URL:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-r[Reinstall the latest Python patch, if it'\''s already installed]' '--reinstall[Reinstall the latest Python patch, if it'\''s already installed]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '*::targets -- The Python minor version(s) to upgrade:_default' && ret=0  ;;
								(find) _arguments "${_arguments_options[@]}" : '(--no-project --system --no-system)--script=[Find the environment for a Python script, rather than the current project]:SCRIPT:_files' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--no-project[Avoid discovering a project or workspace]' '--system[Only find system Python interpreters]' '--no-system[]' '--show-version[Show the Python version that would be used instead of the path to the interpreter]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '::request -- The Python request:_default' && ret=0  ;;
								(pin) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--resolved[Write the resolved Python interpreter path instead of the request]' '--no-resolved[]' '--no-project[Avoid validating the Python pin is compatible with the project or workspace]' '--global[Update the global Python version pin]' '(--resolved)--rm[Remove the Python version pin]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '::request -- The Python version request:_default' && ret=0  ;;
								(dir) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--bin[Show the directory into which \`uv python\` will install Python executables.]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
								(uninstall) _arguments "${_arguments_options[@]}" : '-i+[The directory where the Python was installed]:INSTALL_DIR:_files' '--install-dir=[The directory where the Python was installed]:INSTALL_DIR:_files' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '()--all[Uninstall all managed Python versions]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '*::targets -- The Python version(s) to uninstall:_default' && ret=0  ;;
								(update-shell) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
							esac ;;
					esac ;;
				(pip) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' ":: :_uv__pip_commands" "*::: :->pip" && ret=0 
					case $state in
						(pip) words=($line[1] "${words[@]}") 
							(( CURRENT += 1 ))
							curcontext="${curcontext%:*:*}:uv-pip-command-$line[1]:" 
							case $line[1] in
								(compile) _arguments "${_arguments_options[@]}" : '*-c+[Constrain versions using the given requirements files]:CONSTRAINTS:_default' '*--constraints=[Constrain versions using the given requirements files]:CONSTRAINTS:_default' '*--overrides=[Override versions using the given requirements files]:OVERRIDES:_default' '*-b+[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINTS:_default' '*--build-constraints=[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINTS:_default' '(--all-extras)*--extra=[Include optional dependencies from the specified extra name; may be provided more than once]:EXTRA:_default' '*--group=[Install the specified dependency group from a \`pyproject.toml\`]:GROUP:_default' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' '--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' '--fork-strategy=[The strategy to use when selecting multiple versions of a given package across Python versions and platforms]:FORK_STRATEGY:((fewest\:"Optimize for selecting the fewest number of versions for each package. Older versions may be preferred if they are compatible with a wider range of supported Python versions or platforms"
requires-python\:"Optimize for selecting latest supported version of each package, for each supported Python version"))' '*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-settings-package=[Settings to pass to the PEP 517 build backend for a specific package, specified as \`PACKAGE\:KEY=VALUE\` pairs]:CONFIG_SETTINGS_PACKAGE:_default' '*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE:_default' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for a specific package to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE:_default' '-o+[Write the compiled requirements to the given \`requirements.txt\` or \`pylock.toml\` file]:OUTPUT_FILE:_files' '--output-file=[Write the compiled requirements to the given \`requirements.txt\` or \`pylock.toml\` file]:OUTPUT_FILE:_files' '--format=[The format in which the resolution should be output]:FORMAT:((requirements.txt\:"Export in \`requirements.txt\` format"
pylock.toml\:"Export in \`pylock.toml\` format"))' '--annotation-style=[The style of the annotation comments included in the output file, used to indicate the source of each package]:ANNOTATION_STYLE:((line\:"Render the annotations on a single, comma-separated line"
split\:"Render each annotation on its own line"))' '--custom-compile-command=[The header comment to include at the top of the output file generated by \`uv pip compile\`]:CUSTOM_COMPILE_COMMAND:_default' '-p+[The Python interpreter to use during resolution.]:PYTHON:_default' '--python=[The Python interpreter to use during resolution.]:PYTHON:_default' '(--no-build)*--no-binary=[Don'\''t install pre-built wheels]:NO_BINARY:_default' '(--no-build)*--only-binary=[Only use pre-built wheels; don'\''t build source distributions]:ONLY_BINARY:_default' '--python-version=[The Python version to use for resolution]:PYTHON_VERSION:_default' '--python-platform=[The platform for which requirements should be resolved]:PYTHON_PLATFORM:((windows\:"An alias for \`x86_64-pc-windows-msvc\`, the default target for Windows"
linux\:"An alias for \`x86_64-unknown-linux-gnu\`, the default target for Linux"
macos\:"An alias for \`aarch64-apple-darwin\`, the default target for macOS"
x86_64-pc-windows-msvc\:"A 64-bit x86 Windows target"
i686-pc-windows-msvc\:"A 32-bit x86 Windows target"
x86_64-unknown-linux-gnu\:"An x86 Linux target. Equivalent to \`x86_64-manylinux_2_28\`"
aarch64-apple-darwin\:"An ARM-based macOS target, as seen on Apple Silicon devices"
x86_64-apple-darwin\:"An x86 macOS target"
aarch64-unknown-linux-gnu\:"An ARM64 Linux target. Equivalent to \`aarch64-manylinux_2_28\`"
aarch64-unknown-linux-musl\:"An ARM64 Linux target"
x86_64-unknown-linux-musl\:"An \`x86_64\` Linux target"
x86_64-manylinux2014\:"An \`x86_64\` target for the \`manylinux2014\` platform. Equivalent to \`x86_64-manylinux_2_17\`"
x86_64-manylinux_2_17\:"An \`x86_64\` target for the \`manylinux_2_17\` platform"
x86_64-manylinux_2_28\:"An \`x86_64\` target for the \`manylinux_2_28\` platform"
x86_64-manylinux_2_31\:"An \`x86_64\` target for the \`manylinux_2_31\` platform"
x86_64-manylinux_2_32\:"An \`x86_64\` target for the \`manylinux_2_32\` platform"
x86_64-manylinux_2_33\:"An \`x86_64\` target for the \`manylinux_2_33\` platform"
x86_64-manylinux_2_34\:"An \`x86_64\` target for the \`manylinux_2_34\` platform"
x86_64-manylinux_2_35\:"An \`x86_64\` target for the \`manylinux_2_35\` platform"
x86_64-manylinux_2_36\:"An \`x86_64\` target for the \`manylinux_2_36\` platform"
x86_64-manylinux_2_37\:"An \`x86_64\` target for the \`manylinux_2_37\` platform"
x86_64-manylinux_2_38\:"An \`x86_64\` target for the \`manylinux_2_38\` platform"
x86_64-manylinux_2_39\:"An \`x86_64\` target for the \`manylinux_2_39\` platform"
x86_64-manylinux_2_40\:"An \`x86_64\` target for the \`manylinux_2_40\` platform"
aarch64-manylinux2014\:"An ARM64 target for the \`manylinux2014\` platform. Equivalent to \`aarch64-manylinux_2_17\`"
aarch64-manylinux_2_17\:"An ARM64 target for the \`manylinux_2_17\` platform"
aarch64-manylinux_2_28\:"An ARM64 target for the \`manylinux_2_28\` platform"
aarch64-manylinux_2_31\:"An ARM64 target for the \`manylinux_2_31\` platform"
aarch64-manylinux_2_32\:"An ARM64 target for the \`manylinux_2_32\` platform"
aarch64-manylinux_2_33\:"An ARM64 target for the \`manylinux_2_33\` platform"
aarch64-manylinux_2_34\:"An ARM64 target for the \`manylinux_2_34\` platform"
aarch64-manylinux_2_35\:"An ARM64 target for the \`manylinux_2_35\` platform"
aarch64-manylinux_2_36\:"An ARM64 target for the \`manylinux_2_36\` platform"
aarch64-manylinux_2_37\:"An ARM64 target for the \`manylinux_2_37\` platform"
aarch64-manylinux_2_38\:"An ARM64 target for the \`manylinux_2_38\` platform"
aarch64-manylinux_2_39\:"An ARM64 target for the \`manylinux_2_39\` platform"
aarch64-manylinux_2_40\:"An ARM64 target for the \`manylinux_2_40\` platform"
wasm32-pyodide2024\:"A wasm32 target using the Pyodide 2024 platform. Meant for use with Python 3.12"))' '*--no-emit-package=[Specify a package to omit from the output resolution. Its dependencies will still be included in the resolution. Equivalent to pip-compile'\''s \`--unsafe-package\` option]:NO_EMIT_PACKAGE:_default' '--torch-backend=[The backend to use when fetching packages in the PyTorch ecosystem (e.g., \`cpu\`, \`cu126\`, or \`auto\`)]:TORCH_BACKEND:((auto\:"Select the appropriate PyTorch index based on the operating system and CUDA driver version"
cpu\:"Use the CPU-only PyTorch index"
cu128\:"Use the PyTorch index for CUDA 12.8"
cu126\:"Use the PyTorch index for CUDA 12.6"
cu125\:"Use the PyTorch index for CUDA 12.5"
cu124\:"Use the PyTorch index for CUDA 12.4"
cu123\:"Use the PyTorch index for CUDA 12.3"
cu122\:"Use the PyTorch index for CUDA 12.2"
cu121\:"Use the PyTorch index for CUDA 12.1"
cu120\:"Use the PyTorch index for CUDA 12.0"
cu118\:"Use the PyTorch index for CUDA 11.8"
cu117\:"Use the PyTorch index for CUDA 11.7"
cu116\:"Use the PyTorch index for CUDA 11.6"
cu115\:"Use the PyTorch index for CUDA 11.5"
cu114\:"Use the PyTorch index for CUDA 11.4"
cu113\:"Use the PyTorch index for CUDA 11.3"
cu112\:"Use the PyTorch index for CUDA 11.2"
cu111\:"Use the PyTorch index for CUDA 11.1"
cu110\:"Use the PyTorch index for CUDA 11.0"
cu102\:"Use the PyTorch index for CUDA 10.2"
cu101\:"Use the PyTorch index for CUDA 10.1"
cu100\:"Use the PyTorch index for CUDA 10.0"
cu92\:"Use the PyTorch index for CUDA 9.2"
cu91\:"Use the PyTorch index for CUDA 9.1"
cu90\:"Use the PyTorch index for CUDA 9.0"
cu80\:"Use the PyTorch index for CUDA 8.0"
rocm6.3\:"Use the PyTorch index for ROCm 6.3"
rocm6.2.4\:"Use the PyTorch index for ROCm 6.2.4"
rocm6.2\:"Use the PyTorch index for ROCm 6.2"
rocm6.1\:"Use the PyTorch index for ROCm 6.1"
rocm6.0\:"Use the PyTorch index for ROCm 6.0"
rocm5.7\:"Use the PyTorch index for ROCm 5.7"
rocm5.6\:"Use the PyTorch index for ROCm 5.6"
rocm5.5\:"Use the PyTorch index for ROCm 5.5"
rocm5.4.2\:"Use the PyTorch index for ROCm 5.4.2"
rocm5.4\:"Use the PyTorch index for ROCm 5.4"
rocm5.3\:"Use the PyTorch index for ROCm 5.3"
rocm5.2\:"Use the PyTorch index for ROCm 5.2"
rocm5.1.1\:"Use the PyTorch index for ROCm 5.1.1"
rocm4.2\:"Use the PyTorch index for ROCm 4.2"
rocm4.1\:"Use the PyTorch index for ROCm 4.1"
rocm4.0.1\:"Use the PyTorch index for ROCm 4.0.1"
xpu\:"Use the PyTorch index for Intel XPU"))' '--resolver=[]:RESOLVER:(backtracking legacy)' '--max-rounds=[]:MAX_ROUNDS:_default' '--cert=[]:CERT:_default' '--client-cert=[]:CLIENT_CERT:_default' '--config=[]:CONFIG:_default' '--pip-args=[]:PIP_ARGS:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '(--extra)--all-extras[Include all optional dependencies]' '--no-all-extras[]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--no-upgrade[]' '--pre[]' '--no-build-isolation[Disable isolation when building source distributions]' '--build-isolation[]' '--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources]' '(--offline)--refresh[Refresh all cached data]' '(--offline)--no-refresh[]' '--no-deps[Ignore package dependencies, instead only add those packages explicitly listed on the command line to the resulting requirements file]' '--deps[]' '--no-strip-extras[Include extras in the output file]' '--strip-extras[]' '--no-strip-markers[Include environment markers in the output file]' '--strip-markers[]' '--no-annotate[Exclude comment annotations indicating the source of each package]' '--annotate[]' '--no-header[Exclude the comment header at the top of the generated output file]' '--header[]' '--system[Install packages into the system Python environment]' '--no-system[]' '--generate-hashes[Include distribution hashes in the output file]' '--no-generate-hashes[]' '(--no-binary --only-binary)--no-build[Don'\''t build source distributions]' '(--no-binary --only-binary)--build[]' '(--python-platform --strip-markers)--universal[Perform a universal resolution, attempting to generate a single \`requirements.txt\` output file that is compatible with all operating systems, architectures, and Python implementations]' '--no-universal[]' '--emit-index-url[Include \`--index-url\` and \`--extra-index-url\` entries in the generated output file]' '--no-emit-index-url[]' '--emit-find-links[Include \`--find-links\` entries in the generated output file]' '--no-emit-find-links[]' '--emit-build-options[Include \`--no-binary\` and \`--only-binary\` entries in the generated output file]' '--no-emit-build-options[]' '--emit-marker-expression[Whether to emit a marker string indicating when it is known that the resulting set of pinned dependencies is valid]' '--no-emit-marker-expression[]' '--emit-index-annotation[Include comment annotations indicating the index used to resolve each package (e.g., \`# from https\://pypi.org/simple\`)]' '--no-emit-index-annotation[]' '--allow-unsafe[]' '--no-allow-unsafe[]' '--reuse-hashes[]' '--no-reuse-hashes[]' '--emit-trusted-host[]' '--no-emit-trusted-host[]' '--no-config[]' '--emit-options[]' '--no-emit-options[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '*::src_file -- Include all packages listed in the given `requirements.in` files:_files' && ret=0  ;;
								(sync) _arguments "${_arguments_options[@]}" : '*-c+[Constrain versions using the given requirements files]:CONSTRAINTS:_default' '*--constraints=[Constrain versions using the given requirements files]:CONSTRAINTS:_default' '*-b+[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINTS:_default' '*--build-constraints=[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINTS:_default' '(--all-extras)*--extra=[Include optional dependencies from the specified extra name; may be provided more than once]:EXTRA:_default' '*--group=[Install the specified dependency group from a \`pylock.toml\` or \`pyproject.toml\`]:GROUP:_default' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-settings-package=[Settings to pass to the PEP 517 build backend for a specific package, specified as \`PACKAGE\:KEY=VALUE\` pairs]:CONFIG_SETTINGS_PACKAGE:_default' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for specific packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE:_default' '-p+[The Python interpreter into which packages should be installed.]:PYTHON:_default' '--python=[The Python interpreter into which packages should be installed.]:PYTHON:_default' '(--prefix)--target=[Install packages into the specified directory, rather than into the virtual or system Python environment. The packages will be installed at the top-level of the directory]:TARGET:_files' '(--target)--prefix=[Install packages into \`lib\`, \`bin\`, and other top-level folders under the specified directory, as if a virtual environment were present at that location]:PREFIX:_files' '(--no-build)*--no-binary=[Don'\''t install pre-built wheels]:NO_BINARY:_default' '(--no-build)*--only-binary=[Only use pre-built wheels; don'\''t build source distributions]:ONLY_BINARY:_default' '--python-version=[The minimum Python version that should be supported by the requirements (e.g., \`3.7\` or \`3.7.9\`)]:PYTHON_VERSION:_default' '--python-platform=[The platform for which requirements should be installed]:PYTHON_PLATFORM:((windows\:"An alias for \`x86_64-pc-windows-msvc\`, the default target for Windows"
linux\:"An alias for \`x86_64-unknown-linux-gnu\`, the default target for Linux"
macos\:"An alias for \`aarch64-apple-darwin\`, the default target for macOS"
x86_64-pc-windows-msvc\:"A 64-bit x86 Windows target"
i686-pc-windows-msvc\:"A 32-bit x86 Windows target"
x86_64-unknown-linux-gnu\:"An x86 Linux target. Equivalent to \`x86_64-manylinux_2_28\`"
aarch64-apple-darwin\:"An ARM-based macOS target, as seen on Apple Silicon devices"
x86_64-apple-darwin\:"An x86 macOS target"
aarch64-unknown-linux-gnu\:"An ARM64 Linux target. Equivalent to \`aarch64-manylinux_2_28\`"
aarch64-unknown-linux-musl\:"An ARM64 Linux target"
x86_64-unknown-linux-musl\:"An \`x86_64\` Linux target"
x86_64-manylinux2014\:"An \`x86_64\` target for the \`manylinux2014\` platform. Equivalent to \`x86_64-manylinux_2_17\`"
x86_64-manylinux_2_17\:"An \`x86_64\` target for the \`manylinux_2_17\` platform"
x86_64-manylinux_2_28\:"An \`x86_64\` target for the \`manylinux_2_28\` platform"
x86_64-manylinux_2_31\:"An \`x86_64\` target for the \`manylinux_2_31\` platform"
x86_64-manylinux_2_32\:"An \`x86_64\` target for the \`manylinux_2_32\` platform"
x86_64-manylinux_2_33\:"An \`x86_64\` target for the \`manylinux_2_33\` platform"
x86_64-manylinux_2_34\:"An \`x86_64\` target for the \`manylinux_2_34\` platform"
x86_64-manylinux_2_35\:"An \`x86_64\` target for the \`manylinux_2_35\` platform"
x86_64-manylinux_2_36\:"An \`x86_64\` target for the \`manylinux_2_36\` platform"
x86_64-manylinux_2_37\:"An \`x86_64\` target for the \`manylinux_2_37\` platform"
x86_64-manylinux_2_38\:"An \`x86_64\` target for the \`manylinux_2_38\` platform"
x86_64-manylinux_2_39\:"An \`x86_64\` target for the \`manylinux_2_39\` platform"
x86_64-manylinux_2_40\:"An \`x86_64\` target for the \`manylinux_2_40\` platform"
aarch64-manylinux2014\:"An ARM64 target for the \`manylinux2014\` platform. Equivalent to \`aarch64-manylinux_2_17\`"
aarch64-manylinux_2_17\:"An ARM64 target for the \`manylinux_2_17\` platform"
aarch64-manylinux_2_28\:"An ARM64 target for the \`manylinux_2_28\` platform"
aarch64-manylinux_2_31\:"An ARM64 target for the \`manylinux_2_31\` platform"
aarch64-manylinux_2_32\:"An ARM64 target for the \`manylinux_2_32\` platform"
aarch64-manylinux_2_33\:"An ARM64 target for the \`manylinux_2_33\` platform"
aarch64-manylinux_2_34\:"An ARM64 target for the \`manylinux_2_34\` platform"
aarch64-manylinux_2_35\:"An ARM64 target for the \`manylinux_2_35\` platform"
aarch64-manylinux_2_36\:"An ARM64 target for the \`manylinux_2_36\` platform"
aarch64-manylinux_2_37\:"An ARM64 target for the \`manylinux_2_37\` platform"
aarch64-manylinux_2_38\:"An ARM64 target for the \`manylinux_2_38\` platform"
aarch64-manylinux_2_39\:"An ARM64 target for the \`manylinux_2_39\` platform"
aarch64-manylinux_2_40\:"An ARM64 target for the \`manylinux_2_40\` platform"
wasm32-pyodide2024\:"A wasm32 target using the Pyodide 2024 platform. Meant for use with Python 3.12"))' '--torch-backend=[The backend to use when fetching packages in the PyTorch ecosystem (e.g., \`cpu\`, \`cu126\`, or \`auto\`)]:TORCH_BACKEND:((auto\:"Select the appropriate PyTorch index based on the operating system and CUDA driver version"
cpu\:"Use the CPU-only PyTorch index"
cu128\:"Use the PyTorch index for CUDA 12.8"
cu126\:"Use the PyTorch index for CUDA 12.6"
cu125\:"Use the PyTorch index for CUDA 12.5"
cu124\:"Use the PyTorch index for CUDA 12.4"
cu123\:"Use the PyTorch index for CUDA 12.3"
cu122\:"Use the PyTorch index for CUDA 12.2"
cu121\:"Use the PyTorch index for CUDA 12.1"
cu120\:"Use the PyTorch index for CUDA 12.0"
cu118\:"Use the PyTorch index for CUDA 11.8"
cu117\:"Use the PyTorch index for CUDA 11.7"
cu116\:"Use the PyTorch index for CUDA 11.6"
cu115\:"Use the PyTorch index for CUDA 11.5"
cu114\:"Use the PyTorch index for CUDA 11.4"
cu113\:"Use the PyTorch index for CUDA 11.3"
cu112\:"Use the PyTorch index for CUDA 11.2"
cu111\:"Use the PyTorch index for CUDA 11.1"
cu110\:"Use the PyTorch index for CUDA 11.0"
cu102\:"Use the PyTorch index for CUDA 10.2"
cu101\:"Use the PyTorch index for CUDA 10.1"
cu100\:"Use the PyTorch index for CUDA 10.0"
cu92\:"Use the PyTorch index for CUDA 9.2"
cu91\:"Use the PyTorch index for CUDA 9.1"
cu90\:"Use the PyTorch index for CUDA 9.0"
cu80\:"Use the PyTorch index for CUDA 8.0"
rocm6.3\:"Use the PyTorch index for ROCm 6.3"
rocm6.2.4\:"Use the PyTorch index for ROCm 6.2.4"
rocm6.2\:"Use the PyTorch index for ROCm 6.2"
rocm6.1\:"Use the PyTorch index for ROCm 6.1"
rocm6.0\:"Use the PyTorch index for ROCm 6.0"
rocm5.7\:"Use the PyTorch index for ROCm 5.7"
rocm5.6\:"Use the PyTorch index for ROCm 5.6"
rocm5.5\:"Use the PyTorch index for ROCm 5.5"
rocm5.4.2\:"Use the PyTorch index for ROCm 5.4.2"
rocm5.4\:"Use the PyTorch index for ROCm 5.4"
rocm5.3\:"Use the PyTorch index for ROCm 5.3"
rocm5.2\:"Use the PyTorch index for ROCm 5.2"
rocm5.1.1\:"Use the PyTorch index for ROCm 5.1.1"
rocm4.2\:"Use the PyTorch index for ROCm 4.2"
rocm4.1\:"Use the PyTorch index for ROCm 4.1"
rocm4.0.1\:"Use the PyTorch index for ROCm 4.0.1"
xpu\:"Use the PyTorch index for Intel XPU"))' '--python-executable=[]:PYTHON_EXECUTABLE:_default' '--cert=[]:CERT:_default' '--client-cert=[]:CLIENT_CERT:_default' '--config=[]:CONFIG:_default' '--pip-args=[]:PIP_ARGS:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '(--extra)--all-extras[Include all optional dependencies]' '--no-all-extras[]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' '--no-reinstall[]' '--no-build-isolation[Disable isolation when building source distributions]' '--build-isolation[]' '--compile-bytecode[Compile Python files to bytecode after installation]' '--no-compile-bytecode[]' '--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources]' '(--offline)--refresh[Refresh all cached data]' '(--offline)--no-refresh[]' '--require-hashes[Require a matching hash for each requirement]' '--no-require-hashes[]' '--verify-hashes[]' '--no-verify-hashes[Disable validation of hashes in the requirements file]' '--system[Install packages into the system Python environment]' '--no-system[]' '--break-system-packages[Allow uv to modify an \`EXTERNALLY-MANAGED\` Python installation]' '--no-break-system-packages[]' '(--no-binary --only-binary)--no-build[Don'\''t build source distributions]' '(--no-binary --only-binary)--build[]' '--allow-empty-requirements[Allow sync of empty requirements, which will clear the environment of all packages]' '--no-allow-empty-requirements[]' '--strict[Validate the Python environment after completing the installation, to detect packages with missing dependencies or other issues]' '--no-strict[]' '--dry-run[Perform a dry run, i.e., don'\''t actually install anything but resolve the dependencies and print the resulting plan]' '-a[]' '--ask[]' '--user[]' '--no-config[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '*::src_file -- Include all packages listed in the given `requirements.txt` files:_files' && ret=0  ;;
								(install) _arguments "${_arguments_options[@]}" : '*-r+[Install all packages listed in the given \`requirements.txt\` or \`pylock.toml\` files]:REQUIREMENTS:_files' '*--requirements=[Install all packages listed in the given \`requirements.txt\` or \`pylock.toml\` files]:REQUIREMENTS:_files' '*-e+[Install the editable package based on the provided local file path]:EDITABLE:_default' '*--editable=[Install the editable package based on the provided local file path]:EDITABLE:_default' '*-c+[Constrain versions using the given requirements files]:CONSTRAINTS:_default' '*--constraints=[Constrain versions using the given requirements files]:CONSTRAINTS:_default' '*--overrides=[Override versions using the given requirements files]:OVERRIDES:_default' '*-b+[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINTS:_default' '*--build-constraints=[Constrain build dependencies using the given requirements files when building source distributions]:BUILD_CONSTRAINTS:_default' '(--all-extras)*--extra=[Include optional dependencies from the specified extra name; may be provided more than once]:EXTRA:_default' '*--group=[Install the specified dependency group from a \`pylock.toml\` or \`pyproject.toml\`]:GROUP:_default' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--reinstall-package=[Reinstall a specific package, regardless of whether it'\''s already installed. Implies \`--refresh-package\`]:REINSTALL_PACKAGE:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' '--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' '--fork-strategy=[The strategy to use when selecting multiple versions of a given package across Python versions and platforms]:FORK_STRATEGY:((fewest\:"Optimize for selecting the fewest number of versions for each package. Older versions may be preferred if they are compatible with a wider range of supported Python versions or platforms"
requires-python\:"Optimize for selecting latest supported version of each package, for each supported Python version"))' '*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-settings-package=[Settings to pass to the PEP 517 build backend for a specific package, specified as \`PACKAGE\:KEY=VALUE\` pairs]:CONFIG_SETTINGS_PACKAGE:_default' '*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE:_default' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for specific packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE:_default' '-p+[The Python interpreter into which packages should be installed.]:PYTHON:_default' '--python=[The Python interpreter into which packages should be installed.]:PYTHON:_default' '(--prefix)--target=[Install packages into the specified directory, rather than into the virtual or system Python environment. The packages will be installed at the top-level of the directory]:TARGET:_files' '(--target)--prefix=[Install packages into \`lib\`, \`bin\`, and other top-level folders under the specified directory, as if a virtual environment were present at that location]:PREFIX:_files' '(--no-build)*--no-binary=[Don'\''t install pre-built wheels]:NO_BINARY:_default' '(--no-build)*--only-binary=[Only use pre-built wheels; don'\''t build source distributions]:ONLY_BINARY:_default' '--python-version=[The minimum Python version that should be supported by the requirements (e.g., \`3.7\` or \`3.7.9\`)]:PYTHON_VERSION:_default' '--python-platform=[The platform for which requirements should be installed]:PYTHON_PLATFORM:((windows\:"An alias for \`x86_64-pc-windows-msvc\`, the default target for Windows"
linux\:"An alias for \`x86_64-unknown-linux-gnu\`, the default target for Linux"
macos\:"An alias for \`aarch64-apple-darwin\`, the default target for macOS"
x86_64-pc-windows-msvc\:"A 64-bit x86 Windows target"
i686-pc-windows-msvc\:"A 32-bit x86 Windows target"
x86_64-unknown-linux-gnu\:"An x86 Linux target. Equivalent to \`x86_64-manylinux_2_28\`"
aarch64-apple-darwin\:"An ARM-based macOS target, as seen on Apple Silicon devices"
x86_64-apple-darwin\:"An x86 macOS target"
aarch64-unknown-linux-gnu\:"An ARM64 Linux target. Equivalent to \`aarch64-manylinux_2_28\`"
aarch64-unknown-linux-musl\:"An ARM64 Linux target"
x86_64-unknown-linux-musl\:"An \`x86_64\` Linux target"
x86_64-manylinux2014\:"An \`x86_64\` target for the \`manylinux2014\` platform. Equivalent to \`x86_64-manylinux_2_17\`"
x86_64-manylinux_2_17\:"An \`x86_64\` target for the \`manylinux_2_17\` platform"
x86_64-manylinux_2_28\:"An \`x86_64\` target for the \`manylinux_2_28\` platform"
x86_64-manylinux_2_31\:"An \`x86_64\` target for the \`manylinux_2_31\` platform"
x86_64-manylinux_2_32\:"An \`x86_64\` target for the \`manylinux_2_32\` platform"
x86_64-manylinux_2_33\:"An \`x86_64\` target for the \`manylinux_2_33\` platform"
x86_64-manylinux_2_34\:"An \`x86_64\` target for the \`manylinux_2_34\` platform"
x86_64-manylinux_2_35\:"An \`x86_64\` target for the \`manylinux_2_35\` platform"
x86_64-manylinux_2_36\:"An \`x86_64\` target for the \`manylinux_2_36\` platform"
x86_64-manylinux_2_37\:"An \`x86_64\` target for the \`manylinux_2_37\` platform"
x86_64-manylinux_2_38\:"An \`x86_64\` target for the \`manylinux_2_38\` platform"
x86_64-manylinux_2_39\:"An \`x86_64\` target for the \`manylinux_2_39\` platform"
x86_64-manylinux_2_40\:"An \`x86_64\` target for the \`manylinux_2_40\` platform"
aarch64-manylinux2014\:"An ARM64 target for the \`manylinux2014\` platform. Equivalent to \`aarch64-manylinux_2_17\`"
aarch64-manylinux_2_17\:"An ARM64 target for the \`manylinux_2_17\` platform"
aarch64-manylinux_2_28\:"An ARM64 target for the \`manylinux_2_28\` platform"
aarch64-manylinux_2_31\:"An ARM64 target for the \`manylinux_2_31\` platform"
aarch64-manylinux_2_32\:"An ARM64 target for the \`manylinux_2_32\` platform"
aarch64-manylinux_2_33\:"An ARM64 target for the \`manylinux_2_33\` platform"
aarch64-manylinux_2_34\:"An ARM64 target for the \`manylinux_2_34\` platform"
aarch64-manylinux_2_35\:"An ARM64 target for the \`manylinux_2_35\` platform"
aarch64-manylinux_2_36\:"An ARM64 target for the \`manylinux_2_36\` platform"
aarch64-manylinux_2_37\:"An ARM64 target for the \`manylinux_2_37\` platform"
aarch64-manylinux_2_38\:"An ARM64 target for the \`manylinux_2_38\` platform"
aarch64-manylinux_2_39\:"An ARM64 target for the \`manylinux_2_39\` platform"
aarch64-manylinux_2_40\:"An ARM64 target for the \`manylinux_2_40\` platform"
wasm32-pyodide2024\:"A wasm32 target using the Pyodide 2024 platform. Meant for use with Python 3.12"))' '--torch-backend=[The backend to use when fetching packages in the PyTorch ecosystem (e.g., \`cpu\`, \`cu126\`, or \`auto\`)]:TORCH_BACKEND:((auto\:"Select the appropriate PyTorch index based on the operating system and CUDA driver version"
cpu\:"Use the CPU-only PyTorch index"
cu128\:"Use the PyTorch index for CUDA 12.8"
cu126\:"Use the PyTorch index for CUDA 12.6"
cu125\:"Use the PyTorch index for CUDA 12.5"
cu124\:"Use the PyTorch index for CUDA 12.4"
cu123\:"Use the PyTorch index for CUDA 12.3"
cu122\:"Use the PyTorch index for CUDA 12.2"
cu121\:"Use the PyTorch index for CUDA 12.1"
cu120\:"Use the PyTorch index for CUDA 12.0"
cu118\:"Use the PyTorch index for CUDA 11.8"
cu117\:"Use the PyTorch index for CUDA 11.7"
cu116\:"Use the PyTorch index for CUDA 11.6"
cu115\:"Use the PyTorch index for CUDA 11.5"
cu114\:"Use the PyTorch index for CUDA 11.4"
cu113\:"Use the PyTorch index for CUDA 11.3"
cu112\:"Use the PyTorch index for CUDA 11.2"
cu111\:"Use the PyTorch index for CUDA 11.1"
cu110\:"Use the PyTorch index for CUDA 11.0"
cu102\:"Use the PyTorch index for CUDA 10.2"
cu101\:"Use the PyTorch index for CUDA 10.1"
cu100\:"Use the PyTorch index for CUDA 10.0"
cu92\:"Use the PyTorch index for CUDA 9.2"
cu91\:"Use the PyTorch index for CUDA 9.1"
cu90\:"Use the PyTorch index for CUDA 9.0"
cu80\:"Use the PyTorch index for CUDA 8.0"
rocm6.3\:"Use the PyTorch index for ROCm 6.3"
rocm6.2.4\:"Use the PyTorch index for ROCm 6.2.4"
rocm6.2\:"Use the PyTorch index for ROCm 6.2"
rocm6.1\:"Use the PyTorch index for ROCm 6.1"
rocm6.0\:"Use the PyTorch index for ROCm 6.0"
rocm5.7\:"Use the PyTorch index for ROCm 5.7"
rocm5.6\:"Use the PyTorch index for ROCm 5.6"
rocm5.5\:"Use the PyTorch index for ROCm 5.5"
rocm5.4.2\:"Use the PyTorch index for ROCm 5.4.2"
rocm5.4\:"Use the PyTorch index for ROCm 5.4"
rocm5.3\:"Use the PyTorch index for ROCm 5.3"
rocm5.2\:"Use the PyTorch index for ROCm 5.2"
rocm5.1.1\:"Use the PyTorch index for ROCm 5.1.1"
rocm4.2\:"Use the PyTorch index for ROCm 4.2"
rocm4.1\:"Use the PyTorch index for ROCm 4.1"
rocm4.0.1\:"Use the PyTorch index for ROCm 4.0.1"
xpu\:"Use the PyTorch index for Intel XPU"))' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '(--extra)--all-extras[Include all optional dependencies]' '--no-all-extras[]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--no-upgrade[]' '--reinstall[Reinstall all packages, regardless of whether they'\''re already installed. Implies \`--refresh\`]' '--no-reinstall[]' '--pre[]' '--no-build-isolation[Disable isolation when building source distributions]' '--build-isolation[]' '--compile-bytecode[Compile Python files to bytecode after installation]' '--no-compile-bytecode[]' '--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources]' '(--offline)--refresh[Refresh all cached data]' '(--offline)--no-refresh[]' '--no-deps[Ignore package dependencies, instead only installing those packages explicitly listed on the command line or in the requirements files]' '--deps[]' '--require-hashes[Require a matching hash for each requirement]' '--no-require-hashes[]' '--verify-hashes[]' '--no-verify-hashes[Disable validation of hashes in the requirements file]' '--system[Install packages into the system Python environment]' '--no-system[]' '--break-system-packages[Allow uv to modify an \`EXTERNALLY-MANAGED\` Python installation]' '--no-break-system-packages[]' '(--no-binary --only-binary)--no-build[Don'\''t build source distributions]' '(--no-binary --only-binary)--build[]' '--inexact[Do not remove extraneous packages present in the environment]' '--exact[Perform an exact sync, removing extraneous packages]' '--strict[Validate the Python environment after completing the installation, to detect packages with missing dependencies or other issues]' '--no-strict[]' '--dry-run[Perform a dry run, i.e., don'\''t actually install anything but resolve the dependencies and print the resulting plan]' '--disable-pip-version-check[]' '--user[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '*::package -- Install all listed packages:_default' && ret=0  ;;
								(uninstall) _arguments "${_arguments_options[@]}" : '*-r+[Uninstall all packages listed in the given requirements files]:REQUIREMENTS:_files' '*--requirements=[Uninstall all packages listed in the given requirements files]:REQUIREMENTS:_files' '-p+[The Python interpreter from which packages should be uninstalled.]:PYTHON:_default' '--python=[The Python interpreter from which packages should be uninstalled.]:PYTHON:_default' '--keyring-provider=[Attempt to use \`keyring\` for authentication for remote requirements files]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '(--prefix)--target=[Uninstall packages from the specified \`--target\` directory]:TARGET:_files' '(--target)--prefix=[Uninstall packages from the specified \`--prefix\` directory]:PREFIX:_files' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--system[Use the system Python to uninstall packages]' '--no-system[]' '--break-system-packages[Allow uv to modify an \`EXTERNALLY-MANAGED\` Python installation]' '--no-break-system-packages[]' '--dry-run[Perform a dry run, i.e., don'\''t actually uninstall anything but print the resulting plan]' '--disable-pip-version-check[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '*::package -- Uninstall all listed packages:_default' && ret=0  ;;
								(freeze) _arguments "${_arguments_options[@]}" : '-p+[The Python interpreter for which packages should be listed.]:PYTHON:_default' '--python=[The Python interpreter for which packages should be listed.]:PYTHON:_default' '*--path=[Restrict to the specified installation path for listing packages (can be used multiple times)]:PATHS:_files' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--exclude-editable[Exclude any editable packages from output]' '--strict[Validate the Python environment, to detect packages with missing dependencies and other issues]' '--no-strict[]' '--system[List packages in the system Python environment]' '--no-system[]' '--disable-pip-version-check[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
								(list) _arguments "${_arguments_options[@]}" : '*--exclude=[Exclude the specified package(s) from the output]:EXCLUDE:_default' '--format=[Select the output format]:FORMAT:((columns\:"Display the list of packages in a human-readable table"
freeze\:"Display the list of packages in a \`pip freeze\`-like format, with one package per line alongside its version"
json\:"Display the list of packages in a machine-readable JSON format"))' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '-p+[The Python interpreter for which packages should be listed.]:PYTHON:_default' '--python=[The Python interpreter for which packages should be listed.]:PYTHON:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-e[Only include editable projects]' '--editable[Only include editable projects]' '(-e --editable)--exclude-editable[Exclude any editable packages from output]' '--outdated[List outdated packages]' '--no-outdated[]' '--strict[Validate the Python environment, to detect packages with missing dependencies and other issues]' '--no-strict[]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '--system[List packages in the system Python environment]' '--no-system[]' '--disable-pip-version-check[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
								(show) _arguments "${_arguments_options[@]}" : '-p+[The Python interpreter to find the package in.]:PYTHON:_default' '--python=[The Python interpreter to find the package in.]:PYTHON:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--strict[Validate the Python environment, to detect packages with missing dependencies and other issues]' '--no-strict[]' '-f[Show the full list of installed files for each package]' '--files[Show the full list of installed files for each package]' '--system[Show a package in the system Python environment]' '--no-system[]' '--disable-pip-version-check[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '*::package -- The package(s) to display:_default' && ret=0  ;;
								(tree) _arguments "${_arguments_options[@]}" : '-d+[Maximum display depth of the dependency tree]:DEPTH:_default' '--depth=[Maximum display depth of the dependency tree]:DEPTH:_default' '*--prune=[Prune the given package from the display of the dependency tree]:PRUNE:_default' '*--package=[Display only the specified packages]:PACKAGE:_default' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '-p+[The Python interpreter for which packages should be listed.]:PYTHON:_default' '--python=[The Python interpreter for which packages should be listed.]:PYTHON:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--show-version-specifiers[Show the version constraint(s) imposed on each package]' '--no-dedupe[Do not de-duplicate repeated dependencies. Usually, when a package has already displayed its dependencies, further occurrences will not re-display its dependencies, and will include a (*) to indicate it has already been shown. This flag will cause those duplicates to be repeated]' '--invert[Show the reverse dependencies for the given package. This flag will invert the tree and display the packages that depend on the given package]' '--outdated[Show the latest available version of each package in the tree]' '--strict[Validate the Python environment, to detect packages with missing dependencies and other issues]' '--no-strict[]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '--system[List packages in the system Python environment]' '--no-system[]' '--disable-pip-version-check[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
								(check) _arguments "${_arguments_options[@]}" : '-p+[The Python interpreter for which packages should be checked.]:PYTHON:_default' '--python=[The Python interpreter for which packages should be checked.]:PYTHON:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--system[Check packages in the system Python environment]' '--no-system[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
							esac ;;
					esac ;;
				(venv) _arguments "${_arguments_options[@]}" : '-p+[The Python interpreter to use for the virtual environment.]:PYTHON:_default' '--python=[The Python interpreter to use for the virtual environment.]:PYTHON:_default' '--prompt=[Provide an alternative prompt prefix for the virtual environment.]:PROMPT:_default' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for a specific package to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--system[Ignore virtual environments when searching for the Python interpreter]' '--no-system[This flag is included for compatibility only, it has no effect]' '--no-project[Avoid discovering a project or workspace]' '--seed[Install seed packages (one or more of\: \`pip\`, \`setuptools\`, and \`wheel\`) into the virtual environment]' '-c[Remove any existing files or directories at the target path]' '--clear[Remove any existing files or directories at the target path]' '--allow-existing[Preserve any existing files or directories at the target path]' '--system-site-packages[Give the virtual environment access to the system site packages directory]' '--relocatable[Make the virtual environment relocatable]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '(--offline)--refresh[Refresh all cached data]' '(--offline)--no-refresh[]' '--no-seed[]' '--no-pip[]' '--no-setuptools[]' '--no-wheel[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '::path -- The path to the virtual environment to create:_files' && ret=0  ;;
				(build) _arguments "${_arguments_options[@]}" : '(--all-packages)--package=[Build a specific package in the workspace]:PACKAGE:_default' '-o+[The output directory to which distributions should be written]:OUT_DIR:_files' '--out-dir=[The output directory to which distributions should be written]:OUT_DIR:_files' '*-b+[Constrain build dependencies using the given requirements files when building distributions]:BUILD_CONSTRAINTS:_default' '*--build-constraints=[Constrain build dependencies using the given requirements files when building distributions]:BUILD_CONSTRAINTS:_default' '-p+[The Python interpreter to use for the build environment.]:PYTHON:_default' '--python=[The Python interpreter to use for the build environment.]:PYTHON:_default' '*--index=[The URLs to use when resolving dependencies, in addition to the default index]:INDEX:_default' '--default-index=[The URL of the default package index (by default\: <https\://pypi.org/simple>)]:DEFAULT_INDEX:_default' '-i+[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '--index-url=[(Deprecated\: use \`--default-index\` instead) The URL of the Python package index (by default\: <https\://pypi.org/simple>)]:INDEX_URL:_default' '*--extra-index-url=[(Deprecated\: use \`--index\` instead) Extra URLs of package indexes to use, in addition to \`--index-url\`]:EXTRA_INDEX_URL:_default' '*-f+[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*--find-links=[Locations to search for candidate distributions, in addition to those found in the registry indexes]:FIND_LINKS:_default' '*-P+[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '*--upgrade-package=[Allow upgrades for a specific package, ignoring pinned versions in any existing output file. Implies \`--refresh-package\`]:UPGRADE_PACKAGE:_default' '--index-strategy=[The strategy to use when resolving against multiple index URLs]:INDEX_STRATEGY:((first-index\:"Only use results from the first index that returns a match for a given package name"
unsafe-first-match\:"Search for every package name across all indexes, exhausting the versions from the first index before moving on to the next"
unsafe-best-match\:"Search for every package name across all indexes, preferring the "best" version found. If a package version is in multiple indexes, only look at the entry for the first index"))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for index URLs]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--resolution=[The strategy to use when selecting between the different compatible versions for a given package requirement]:RESOLUTION:((highest\:"Resolve the highest compatible version of each package"
lowest\:"Resolve the lowest compatible version of each package"
lowest-direct\:"Resolve the lowest compatible version of any direct dependencies, and the highest compatible version of any transitive dependencies"))' '--prerelease=[The strategy to use when considering pre-release versions]:PRERELEASE:((disallow\:"Disallow all pre-release versions"
allow\:"Allow all pre-release versions"
if-necessary\:"Allow pre-release versions if all versions of a package are pre-release"
explicit\:"Allow pre-release versions for first-party packages with explicit pre-release markers in their version requirements"
if-necessary-or-explicit\:"Allow pre-release versions if all versions of a package are pre-release, or if the package has an explicit pre-release marker in its version requirements"))' '--fork-strategy=[The strategy to use when selecting multiple versions of a given package across Python versions and platforms]:FORK_STRATEGY:((fewest\:"Optimize for selecting the fewest number of versions for each package. Older versions may be preferred if they are compatible with a wider range of supported Python versions or platforms"
requires-python\:"Optimize for selecting latest supported version of each package, for each supported Python version"))' '*-C+[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-setting=[Settings to pass to the PEP 517 build backend, specified as \`KEY=VALUE\` pairs]:CONFIG_SETTING:_default' '*--config-settings-package=[Settings to pass to the PEP 517 build backend for a specific package, specified as \`PACKAGE\:KEY=VALUE\` pairs]:CONFIG_SETTINGS_PACKAGE:_default' '*--no-build-isolation-package=[Disable isolation when building source distributions for a specific package]:NO_BUILD_ISOLATION_PACKAGE:_default' '--exclude-newer=[Limit candidate packages to those that were uploaded prior to the given date]:EXCLUDE_NEWER:_default' '*--exclude-newer-package=[Limit candidate packages for a specific package to those that were uploaded prior to the given date]:EXCLUDE_NEWER_PACKAGE:_default' '--link-mode=[The method to use when installing packages from the global cache]:LINK_MODE:((clone\:"Clone (i.e., copy-on-write) packages from the wheel into the \`site-packages\` directory"
copy\:"Copy packages from the wheel into the \`site-packages\` directory"
hardlink\:"Hard link packages from the wheel into the \`site-packages\` directory"
symlink\:"Symbolically link packages from the wheel into the \`site-packages\` directory"))' '*--no-build-package=[Don'\''t build source distributions for a specific package]:NO_BUILD_PACKAGE:_default' '*--no-binary-package=[Don'\''t install pre-built wheels for a specific package]:NO_BINARY_PACKAGE:_default' '*--refresh-package=[Refresh cached data for a specific package]:REFRESH_PACKAGE:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '(--package)--all-packages[Builds all packages in the workspace]' '--sdist[Build a source distribution ("sdist") from the given directory]' '--wheel[Build a binary distribution ("wheel") from the given directory]' '--list[When using the uv build backend, list the files that would be included when building]' '--build-logs[]' '--no-build-logs[Hide logs from the build backend]' '(--list)--force-pep517[Always build through PEP 517, don'\''t use the fast path for the uv build backend]' '--require-hashes[Require a matching hash for each requirement]' '--no-require-hashes[]' '--verify-hashes[]' '--no-verify-hashes[Disable validation of hashes in the requirements file]' '--no-index[Ignore the registry index (e.g., PyPI), instead relying on direct URL dependencies and those provided via \`--find-links\`]' '-U[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--upgrade[Allow package upgrades, ignoring pinned versions in any existing output file. Implies \`--refresh\`]' '--no-upgrade[]' '--pre[]' '--no-build-isolation[Disable isolation when building source distributions]' '--build-isolation[]' '--no-sources[Ignore the \`tool.uv.sources\` table when resolving dependencies. Used to lock against the standards-compliant, publishable package metadata, as opposed to using any workspace, Git, URL, or local path sources]' '--no-build[Don'\''t build source distributions]' '--build[]' '--no-binary[Don'\''t install pre-built wheels]' '--binary[]' '(--offline)--refresh[Refresh all cached data]' '(--offline)--no-refresh[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '::src -- The directory from which distributions should be built, or a source distribution archive to build into a wheel:_files' && ret=0  ;;
				(publish) _arguments "${_arguments_options[@]}" : '(--publish-url --check-url)--index=[The name of an index in the configuration to use for publishing.]:INDEX:_default' '-u+[The username for the upload]:USERNAME:_default' '--username=[The username for the upload]:USERNAME:_default' '-p+[The password for the upload]:PASSWORD:_default' '--password=[The password for the upload]:PASSWORD:_default' '(-u --username -p --password)-t+[The token for the upload]:TOKEN:_default' '(-u --username -p --password)--token=[The token for the upload]:TOKEN:_default' '--trusted-publishing=[Configure using trusted publishing through GitHub Actions]:TRUSTED_PUBLISHING:((automatic\:"Try trusted publishing when we'\''re already in GitHub Actions, continue if that fails"
always\:""
never\:""))' '--keyring-provider=[Attempt to use \`keyring\` for authentication for remote requirements files]:KEYRING_PROVIDER:((disabled\:"Do not use keyring for credential lookup"
subprocess\:"Use the \`keyring\` command for credential lookup"))' '--publish-url=[The URL of the upload endpoint (not the index URL)]:PUBLISH_URL:_default' '--check-url=[Check an index URL for existing files to skip duplicate uploads]:CHECK_URL:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--skip-existing[]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '*::files -- Paths to the files to upload. Accepts glob expressions:_default' && ret=0  ;;
				(build-backend) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' ":: :_uv__build-backend_commands" "*::: :->build-backend" && ret=0 
					case $state in
						(build-backend) words=($line[1] "${words[@]}") 
							(( CURRENT += 1 ))
							curcontext="${curcontext%:*:*}:uv-build-backend-command-$line[1]:" 
							case $line[1] in
								(build-sdist) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' ':sdist_directory:_files' && ret=0  ;;
								(build-wheel) _arguments "${_arguments_options[@]}" : '--metadata-directory=[]:METADATA_DIRECTORY:_files' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' ':wheel_directory:_files' && ret=0  ;;
								(build-editable) _arguments "${_arguments_options[@]}" : '--metadata-directory=[]:METADATA_DIRECTORY:_files' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' ':wheel_directory:_files' && ret=0  ;;
								(get-requires-for-build-sdist) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
								(get-requires-for-build-wheel) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
								(prepare-metadata-for-build-wheel) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' ':wheel_directory:_files' && ret=0  ;;
								(get-requires-for-build-editable) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
								(prepare-metadata-for-build-editable) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' ':wheel_directory:_files' && ret=0  ;;
							esac ;;
					esac ;;
				(cache) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' ":: :_uv__cache_commands" "*::: :->cache" && ret=0 
					case $state in
						(cache) words=($line[1] "${words[@]}") 
							(( CURRENT += 1 ))
							curcontext="${curcontext%:*:*}:uv-cache-command-$line[1]:" 
							case $line[1] in
								(clean) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '*::package -- The packages to remove from the cache:_default' && ret=0  ;;
								(prune) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--ci[Optimize the cache for persistence in a continuous integration environment, like GitHub Actions]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
								(dir) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
							esac ;;
					esac ;;
				(self) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' ":: :_uv__self_commands" "*::: :->self" && ret=0 
					case $state in
						(self) words=($line[1] "${words[@]}") 
							(( CURRENT += 1 ))
							curcontext="${curcontext%:*:*}:uv-self-command-$line[1]:" 
							case $line[1] in
								(update) _arguments "${_arguments_options[@]}" : '--token=[A GitHub token for authentication. A token is not required but can be used to reduce the chance of encountering rate limits]:TOKEN:_default' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--dry-run[Run without performing the update]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '::target_version -- Update to the specified version. If not provided, uv will update to the latest version:_default' && ret=0  ;;
								(version) _arguments "${_arguments_options[@]}" : '--output-format=[]:OUTPUT_FORMAT:((text\:"Display the version as plain text"
json\:"Display the version as JSON"))' '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--short[Only print the version]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' && ret=0  ;;
							esac ;;
					esac ;;
				(clean) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '*::package -- The packages to remove from the cache:_default' && ret=0  ;;
				(generate-shell-completion) _arguments "${_arguments_options[@]}" : '--cache-dir=[]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '(--no-color)--color=[]:COLOR:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '--config-file=[]:CONFIG_FILE:_files' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '-n[]' '--no-cache[]' '--no-python-downloads[]' '(-v --verbose)*-q[]' '(-v --verbose)*--quiet[]' '(-q --quiet)*-v[]' '(-q --quiet)*--verbose[]' '--native-tls[]' '--offline[]' '--no-progress[]' '--no-config[]' '-h[]' '--help[]' '-V[]' '--version[]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '(--color)--no-color[Disable colors]' '--no-native-tls[]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' ':shell -- The shell to generate the completion script for:(bash elvish fish nushell powershell zsh)' && ret=0  ;;
				(help) _arguments "${_arguments_options[@]}" : '--cache-dir=[Path to the cache directory]:CACHE_DIR:_files' '--python-preference=[]:PYTHON_PREFERENCE:((only-managed\:"Only use managed Python installations; never use system Python installations"
managed\:"Prefer managed Python installations over system Python installations"
system\:"Prefer system Python installations over managed Python installations"
only-system\:"Only use system Python installations; never use managed Python installations"))' '--python-fetch=[Deprecated version of \[\`Self\:\:python_downloads\`\]]:PYTHON_FETCH:((automatic\:"Automatically download managed Python installations when needed"
manual\:"Do not automatically download managed Python installations; require explicit installation"
never\:"Do not ever allow Python downloads"))' '(--no-color)--color=[Control the use of color in output]:COLOR_CHOICE:((auto\:"Enables colored output only when the output is going to a terminal or TTY with support"
always\:"Enables colored output regardless of the detected environment"
never\:"Disables colored output"))' '*--allow-insecure-host=[Allow insecure connections to a host]:ALLOW_INSECURE_HOST:_default' '*--preview-features=[Enable experimental preview features]:PREVIEW_FEATURES:_default' '--directory=[Change to the given directory prior to running the command]:DIRECTORY:_files' '--project=[Run the command within the given project directory]:PROJECT:_files' '--config-file=[The path to a \`uv.toml\` file to use for configuration]:CONFIG_FILE:_files' '--no-pager[Disable pager when printing help]' '-n[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '--no-cache[Avoid reading from or writing to the cache, instead using a temporary directory for the duration of the operation]' '(--python-preference)--managed-python[Require use of uv-managed Python versions]' '(--python-preference)--no-managed-python[Disable use of uv-managed Python versions]' '--allow-python-downloads[Allow automatically downloading Python when required. \[env\: "UV_PYTHON_DOWNLOADS=auto"\]]' '--no-python-downloads[Disable automatic downloads of Python. \[env\: "UV_PYTHON_DOWNLOADS=never"\]]' '(-v --verbose)*-q[Use quiet output]' '(-v --verbose)*--quiet[Use quiet output]' '(-q --quiet)*-v[Use verbose output]' '(-q --quiet)*--verbose[Use verbose output]' '(--color)--no-color[Disable colors]' '--native-tls[Whether to load TLS certificates from the platform'\''s native certificate store]' '--no-native-tls[]' '--offline[Disable network access]' '--no-offline[]' '--preview[Whether to enable all experimental preview features]' '--no-preview[]' '--isolated[Avoid discovering a \`pyproject.toml\` or \`uv.toml\` file]' '--show-settings[Show the resolved settings for the current command]' '--no-progress[Hide all progress outputs]' '--no-installer-metadata[Skip writing \`uv\` installer metadata files (e.g., \`INSTALLER\`, \`REQUESTED\`, and \`direct_url.json\`) to site-packages \`.dist-info\` directories]' '--no-config[Avoid discovering configuration files (\`pyproject.toml\`, \`uv.toml\`)]' '-h[Display the concise help for this command]' '--help[Display the concise help for this command]' '*::command:_default' && ret=0  ;;
			esac ;;
	esac
}
_uv__add_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv add commands' commands "$@"
}
_uv__build-backend__build-editable_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv build-backend build-editable commands' commands "$@"
}
_uv__build-backend__build-sdist_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv build-backend build-sdist commands' commands "$@"
}
_uv__build-backend__build-wheel_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv build-backend build-wheel commands' commands "$@"
}
_uv__build-backend__get-requires-for-build-editable_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv build-backend get-requires-for-build-editable commands' commands "$@"
}
_uv__build-backend__get-requires-for-build-sdist_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv build-backend get-requires-for-build-sdist commands' commands "$@"
}
_uv__build-backend__get-requires-for-build-wheel_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv build-backend get-requires-for-build-wheel commands' commands "$@"
}
_uv__build-backend__prepare-metadata-for-build-editable_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv build-backend prepare-metadata-for-build-editable commands' commands "$@"
}
_uv__build-backend__prepare-metadata-for-build-wheel_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv build-backend prepare-metadata-for-build-wheel commands' commands "$@"
}
_uv__build-backend_commands () {
	local commands
	commands=('build-sdist:PEP 517 hook \`build_sdist\`' 'build-wheel:PEP 517 hook \`build_wheel\`' 'build-editable:PEP 660 hook \`build_editable\`' 'get-requires-for-build-sdist:PEP 517 hook \`get_requires_for_build_sdist\`' 'get-requires-for-build-wheel:PEP 517 hook \`get_requires_for_build_wheel\`' 'prepare-metadata-for-build-wheel:PEP 517 hook \`prepare_metadata_for_build_wheel\`' 'get-requires-for-build-editable:PEP 660 hook \`get_requires_for_build_editable\`' 'prepare-metadata-for-build-editable:PEP 660 hook \`prepare_metadata_for_build_editable\`') 
	_describe -t commands 'uv build-backend commands' commands "$@"
}
_uv__build_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv build commands' commands "$@"
}
_uv__cache__clean_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv cache clean commands' commands "$@"
}
_uv__cache__dir_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv cache dir commands' commands "$@"
}
_uv__cache__prune_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv cache prune commands' commands "$@"
}
_uv__cache_commands () {
	local commands
	commands=('clean:Clear the cache, removing all entries or those linked to specific packages' 'prune:Prune all unreachable objects from the cache' 'dir:Show the cache directory') 
	_describe -t commands 'uv cache commands' commands "$@"
}
_uv__clean_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv clean commands' commands "$@"
}
_uv__export_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv export commands' commands "$@"
}
_uv__generate-shell-completion_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv generate-shell-completion commands' commands "$@"
}
_uv__help_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv help commands' commands "$@"
}
_uv__init_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv init commands' commands "$@"
}
_uv__lock_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv lock commands' commands "$@"
}
_uv__pip__check_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv pip check commands' commands "$@"
}
_uv__pip__compile_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv pip compile commands' commands "$@"
}
_uv__pip__freeze_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv pip freeze commands' commands "$@"
}
_uv__pip__install_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv pip install commands' commands "$@"
}
_uv__pip__list_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv pip list commands' commands "$@"
}
_uv__pip__show_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv pip show commands' commands "$@"
}
_uv__pip__sync_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv pip sync commands' commands "$@"
}
_uv__pip__tree_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv pip tree commands' commands "$@"
}
_uv__pip__uninstall_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv pip uninstall commands' commands "$@"
}
_uv__pip_commands () {
	local commands
	commands=('compile:Compile a \`requirements.in\` file to a \`requirements.txt\` or \`pylock.toml\` file' 'sync:Sync an environment with a \`requirements.txt\` or \`pylock.toml\` file' 'install:Install packages into an environment' 'uninstall:Uninstall packages from an environment' 'freeze:List, in requirements format, packages installed in an environment' 'list:List, in tabular format, packages installed in an environment' 'show:Show information about one or more installed packages' 'tree:Display the dependency tree for an environment' 'check:Verify installed packages have compatible dependencies') 
	_describe -t commands 'uv pip commands' commands "$@"
}
_uv__publish_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv publish commands' commands "$@"
}
_uv__python__dir_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv python dir commands' commands "$@"
}
_uv__python__find_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv python find commands' commands "$@"
}
_uv__python__install_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv python install commands' commands "$@"
}
_uv__python__list_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv python list commands' commands "$@"
}
_uv__python__pin_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv python pin commands' commands "$@"
}
_uv__python__uninstall_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv python uninstall commands' commands "$@"
}
_uv__python__update-shell_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv python update-shell commands' commands "$@"
}
_uv__python__upgrade_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv python upgrade commands' commands "$@"
}
_uv__python_commands () {
	local commands
	commands=('list:List the available Python installations' 'install:Download and install Python versions' 'upgrade:Upgrade installed Python versions' 'find:Search for a Python installation' 'pin:Pin to a specific Python version' 'dir:Show the uv Python installation directory' 'uninstall:Uninstall Python versions' 'update-shell:Ensure that the Python executable directory is on the \`PATH\`') 
	_describe -t commands 'uv python commands' commands "$@"
}
_uv__remove_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv remove commands' commands "$@"
}
_uv__run_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv run commands' commands "$@"
}
_uv__self__update_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv self update commands' commands "$@"
}
_uv__self__version_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv self version commands' commands "$@"
}
_uv__self_commands () {
	local commands
	commands=('update:Update uv' 'version:Display uv'\''s version') 
	_describe -t commands 'uv self commands' commands "$@"
}
_uv__sync_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv sync commands' commands "$@"
}
_uv__tool__dir_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv tool dir commands' commands "$@"
}
_uv__tool__install_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv tool install commands' commands "$@"
}
_uv__tool__list_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv tool list commands' commands "$@"
}
_uv__tool__run_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv tool run commands' commands "$@"
}
_uv__tool__uninstall_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv tool uninstall commands' commands "$@"
}
_uv__tool__update-shell_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv tool update-shell commands' commands "$@"
}
_uv__tool__upgrade_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv tool upgrade commands' commands "$@"
}
_uv__tool__uvx_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv tool uvx commands' commands "$@"
}
_uv__tool_commands () {
	local commands
	commands=('run:Run a command provided by a Python package' 'uvx:Run a command provided by a Python package.' 'install:Install commands provided by a Python package' 'upgrade:Upgrade installed tools' 'list:List installed tools' 'uninstall:Uninstall a tool' 'update-shell:Ensure that the tool executable directory is on the \`PATH\`' 'dir:Show the path to the uv tools directory') 
	_describe -t commands 'uv tool commands' commands "$@"
}
_uv__tree_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv tree commands' commands "$@"
}
_uv__venv_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv venv commands' commands "$@"
}
_uv__version_commands () {
	local commands
	commands=() 
	_describe -t commands 'uv version commands' commands "$@"
}
_uv_commands () {
	local commands
	commands=('run:Run a command or script' 'init:Create a new project' 'add:Add dependencies to the project' 'remove:Remove dependencies from the project' 'version:Read or update the project'\''s version' 'sync:Update the project'\''s environment' 'lock:Update the project'\''s lockfile' 'export:Export the project'\''s lockfile to an alternate format' 'tree:Display the project'\''s dependency tree' 'tool:Run and install commands provided by Python packages' 'python:Manage Python versions and installations' 'pip:Manage Python packages with a pip-compatible interface' 'venv:Create a virtual environment' 'build:Build Python packages into source distributions and wheels' 'publish:Upload distributions to an index' 'build-backend:The implementation of the build backend' 'cache:Manage uv'\''s cache' 'self:Manage the uv executable' 'clean:Clear the cache, removing all entries or those linked to specific packages' 'generate-shell-completion:Generate shell completion' 'help:Display documentation for a command') 
	_describe -t commands 'uv commands' commands "$@"
}
_uvx () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_valgrind () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_value () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_values () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_vared () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_vars () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_vcs_info () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_vcs_info_hooks () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_vi () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_vim () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_vim-addons () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_visudo () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_vmctl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_vmstat () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_vnc () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_volume_groups () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_vorbis () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_vpnc () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_vserver () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_w () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_w3m () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_wait () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_wajig () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_wakeup_capable_devices () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_wanna-build () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_wanted () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_watch () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_watch-snoop () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_wc () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_webbrowser () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_wget () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_whereis () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_which () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_who () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_whois () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_widgets () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_wiggle () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_wipefs () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_wpa_cli () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_arguments () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_borderwidth () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_color () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_colormapid () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_cursor () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_display () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_extension () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_font () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_geometry () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_keysym () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_locale () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_modifier () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_name () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_resource () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_selection_timeout () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_title () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_utils () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_visual () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_x_window () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xargs () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xauth () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xautolock () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xclip () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xcode-select () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xdvi () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xfig () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xft_fonts () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xinput () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xloadimage () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xmlsoft () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xmlstarlet () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xmms2 () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xmodmap () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xournal () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xpdf () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xrandr () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xscreensaver () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xset () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xt_arguments () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xt_session_id () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xterm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xv () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xwit () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xxd () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_xz () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ya () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_yafc () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_yast () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_yazi () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_yodl () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_yp () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_yq () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_yt-dlp () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_yum () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zargs () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zattr () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zcalc () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zcalc_line () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zcat () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zcompile () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zdump () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zeal () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zed () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zfs () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zfs_dataset () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zfs_pool () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zftp () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zip () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zle () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zlogin () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zmodload () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zmv () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zoneadm () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zones () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zoxide () {
	# undefined
	builtin autoload -XUz /opt/homebrew/share/zsh/site-functions
}
_zparseopts () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zpty () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zsh () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zsh-mime-handler () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zsh_autosuggest_accept () {
	local -i retval max_cursor_pos=$#BUFFER 
	if [[ "$KEYMAP" = "vicmd" ]]
	then
		max_cursor_pos=$((max_cursor_pos - 1)) 
	fi
	if (( $CURSOR != $max_cursor_pos || !$#POSTDISPLAY ))
	then
		_zsh_autosuggest_invoke_original_widget $@
		return
	fi
	BUFFER="$BUFFER$POSTDISPLAY" 
	POSTDISPLAY= 
	_zsh_autosuggest_invoke_original_widget $@
	retval=$? 
	if [[ "$KEYMAP" = "vicmd" ]]
	then
		CURSOR=$(($#BUFFER - 1)) 
	else
		CURSOR=$#BUFFER 
	fi
	return $retval
}
_zsh_autosuggest_async_request () {
	zmodload zsh/system 2> /dev/null
	typeset -g _ZSH_AUTOSUGGEST_ASYNC_FD _ZSH_AUTOSUGGEST_CHILD_PID
	if [[ -n "$_ZSH_AUTOSUGGEST_ASYNC_FD" ]] && {
			true <&$_ZSH_AUTOSUGGEST_ASYNC_FD
		} 2> /dev/null
	then
		builtin exec {_ZSH_AUTOSUGGEST_ASYNC_FD}<&-
		zle -F $_ZSH_AUTOSUGGEST_ASYNC_FD
		if [[ -n "$_ZSH_AUTOSUGGEST_CHILD_PID" ]]
		then
			if [[ -o MONITOR ]]
			then
				kill -TERM -$_ZSH_AUTOSUGGEST_CHILD_PID 2> /dev/null
			else
				kill -TERM $_ZSH_AUTOSUGGEST_CHILD_PID 2> /dev/null
			fi
		fi
	fi
	builtin exec {_ZSH_AUTOSUGGEST_ASYNC_FD}< <(
		# Tell parent process our pid
		echo $sysparams[pid]

		# Fetch and print the suggestion
		local suggestion
		_zsh_autosuggest_fetch_suggestion "$1"
		echo -nE "$suggestion"
	)
	autoload -Uz is-at-least
	is-at-least 5.8 || command true
	read _ZSH_AUTOSUGGEST_CHILD_PID <&$_ZSH_AUTOSUGGEST_ASYNC_FD
	zle -F "$_ZSH_AUTOSUGGEST_ASYNC_FD" _zsh_autosuggest_async_response
}
_zsh_autosuggest_async_response () {
	emulate -L zsh
	local suggestion
	if [[ -z "$2" || "$2" == "hup" ]]
	then
		IFS='' read -rd '' -u $1 suggestion
		zle autosuggest-suggest -- "$suggestion"
		builtin exec {1}<&-
	fi
	zle -F "$1"
	_ZSH_AUTOSUGGEST_ASYNC_FD= 
}
_zsh_autosuggest_bind_widget () {
	typeset -gA _ZSH_AUTOSUGGEST_BIND_COUNTS
	local widget=$1 
	local autosuggest_action=$2 
	local prefix=$ZSH_AUTOSUGGEST_ORIGINAL_WIDGET_PREFIX 
	local -i bind_count
	case $widgets[$widget] in
		(user:_zsh_autosuggest_(bound|orig)_*) bind_count=$((_ZSH_AUTOSUGGEST_BIND_COUNTS[$widget]))  ;;
		(user:*) _zsh_autosuggest_incr_bind_count $widget
			zle -N $prefix$bind_count-$widget ${widgets[$widget]#*:} ;;
		(builtin) _zsh_autosuggest_incr_bind_count $widget
			eval "_zsh_autosuggest_orig_${(q)widget}() { zle .${(q)widget} }"
			zle -N $prefix$bind_count-$widget _zsh_autosuggest_orig_$widget ;;
		(completion:*) _zsh_autosuggest_incr_bind_count $widget
			eval "zle -C $prefix$bind_count-${(q)widget} ${${(s.:.)widgets[$widget]}[2,3]}" ;;
	esac
	eval "_zsh_autosuggest_bound_${bind_count}_${(q)widget}() {
		_zsh_autosuggest_widget_$autosuggest_action $prefix$bind_count-${(q)widget} \$@
	}"
	zle -N -- $widget _zsh_autosuggest_bound_${bind_count}_$widget
}
_zsh_autosuggest_bind_widgets () {
	emulate -L zsh
	local widget
	local ignore_widgets
	ignore_widgets=(.\* _\* ${_ZSH_AUTOSUGGEST_BUILTIN_ACTIONS/#/autosuggest-} $ZSH_AUTOSUGGEST_ORIGINAL_WIDGET_PREFIX\* $ZSH_AUTOSUGGEST_IGNORE_WIDGETS) 
	for widget in ${${(f)"$(builtin zle -la)"}:#${(j:|:)~ignore_widgets}}
	do
		if [[ -n ${ZSH_AUTOSUGGEST_CLEAR_WIDGETS[(r)$widget]} ]]
		then
			_zsh_autosuggest_bind_widget $widget clear
		elif [[ -n ${ZSH_AUTOSUGGEST_ACCEPT_WIDGETS[(r)$widget]} ]]
		then
			_zsh_autosuggest_bind_widget $widget accept
		elif [[ -n ${ZSH_AUTOSUGGEST_EXECUTE_WIDGETS[(r)$widget]} ]]
		then
			_zsh_autosuggest_bind_widget $widget execute
		elif [[ -n ${ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS[(r)$widget]} ]]
		then
			_zsh_autosuggest_bind_widget $widget partial_accept
		else
			_zsh_autosuggest_bind_widget $widget modify
		fi
	done
}
_zsh_autosuggest_capture_completion_async () {
	_zsh_autosuggest_capture_setup
	zmodload zsh/parameter 2> /dev/null || return
	autoload +X _complete
	functions[_original_complete]=$functions[_complete] 
	_complete () {
		unset 'compstate[vared]'
		_original_complete "$@"
	}
	vared 1
}
_zsh_autosuggest_capture_completion_sync () {
	_zsh_autosuggest_capture_setup
	zle autosuggest-capture-completion
}
_zsh_autosuggest_capture_completion_widget () {
	local -a +h comppostfuncs
	comppostfuncs=(_zsh_autosuggest_capture_postcompletion) 
	CURSOR=$#BUFFER 
	zle -- ${(k)widgets[(r)completion:.complete-word:_main_complete]}
	if is-at-least 5.0.3
	then
		stty -onlcr -ocrnl -F /dev/tty
	fi
	echo -nE - $'\0'$BUFFER$'\0'
}
_zsh_autosuggest_capture_postcompletion () {
	compstate[insert]=1 
	unset 'compstate[list]'
}
_zsh_autosuggest_capture_setup () {
	if ! is-at-least 5.4
	then
		zshexit () {
			kill -KILL $$ 2>&- || command kill -KILL $$
			sleep 1
		}
	fi
	zstyle ':completion:*' matcher-list ''
	zstyle ':completion:*' path-completion false
	zstyle ':completion:*' max-errors 0 not-numeric
	bindkey '^I' autosuggest-capture-completion
}
_zsh_autosuggest_clear () {
	POSTDISPLAY= 
	_zsh_autosuggest_invoke_original_widget $@
}
_zsh_autosuggest_disable () {
	typeset -g _ZSH_AUTOSUGGEST_DISABLED
	_zsh_autosuggest_clear
}
_zsh_autosuggest_enable () {
	unset _ZSH_AUTOSUGGEST_DISABLED
	if (( $#BUFFER ))
	then
		_zsh_autosuggest_fetch
	fi
}
_zsh_autosuggest_escape_command () {
	setopt localoptions EXTENDED_GLOB
	echo -E "${1//(#m)[\"\'\\()\[\]|*?~]/\\$MATCH}"
}
_zsh_autosuggest_execute () {
	BUFFER="$BUFFER$POSTDISPLAY" 
	POSTDISPLAY= 
	_zsh_autosuggest_invoke_original_widget "accept-line"
}
_zsh_autosuggest_fetch () {
	if (( ${+ZSH_AUTOSUGGEST_USE_ASYNC} ))
	then
		_zsh_autosuggest_async_request "$BUFFER"
	else
		local suggestion
		_zsh_autosuggest_fetch_suggestion "$BUFFER"
		_zsh_autosuggest_suggest "$suggestion"
	fi
}
_zsh_autosuggest_fetch_suggestion () {
	typeset -g suggestion
	local -a strategies
	local strategy
	strategies=(${=ZSH_AUTOSUGGEST_STRATEGY}) 
	for strategy in $strategies
	do
		_zsh_autosuggest_strategy_$strategy "$1"
		[[ "$suggestion" != "$1"* ]] && unset suggestion
		[[ -n "$suggestion" ]] && break
	done
}
_zsh_autosuggest_highlight_apply () {
	typeset -g _ZSH_AUTOSUGGEST_LAST_HIGHLIGHT
	if (( $#POSTDISPLAY ))
	then
		typeset -g _ZSH_AUTOSUGGEST_LAST_HIGHLIGHT="$#BUFFER $(($#BUFFER + $#POSTDISPLAY)) $ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE" 
		region_highlight+=("$_ZSH_AUTOSUGGEST_LAST_HIGHLIGHT") 
	else
		unset _ZSH_AUTOSUGGEST_LAST_HIGHLIGHT
	fi
}
_zsh_autosuggest_highlight_reset () {
	typeset -g _ZSH_AUTOSUGGEST_LAST_HIGHLIGHT
	if [[ -n "$_ZSH_AUTOSUGGEST_LAST_HIGHLIGHT" ]]
	then
		region_highlight=("${(@)region_highlight:#$_ZSH_AUTOSUGGEST_LAST_HIGHLIGHT}") 
		unset _ZSH_AUTOSUGGEST_LAST_HIGHLIGHT
	fi
}
_zsh_autosuggest_incr_bind_count () {
	typeset -gi bind_count=$((_ZSH_AUTOSUGGEST_BIND_COUNTS[$1]+1)) 
	_ZSH_AUTOSUGGEST_BIND_COUNTS[$1]=$bind_count 
}
_zsh_autosuggest_invoke_original_widget () {
	(( $# )) || return 0
	local original_widget_name="$1" 
	shift
	if (( ${+widgets[$original_widget_name]} ))
	then
		zle $original_widget_name -- $@
	fi
}
_zsh_autosuggest_modify () {
	local -i retval
	local -i KEYS_QUEUED_COUNT
	local orig_buffer="$BUFFER" 
	local orig_postdisplay="$POSTDISPLAY" 
	POSTDISPLAY= 
	_zsh_autosuggest_invoke_original_widget $@
	retval=$? 
	emulate -L zsh
	if (( $PENDING > 0 || $KEYS_QUEUED_COUNT > 0 ))
	then
		POSTDISPLAY="$orig_postdisplay" 
		return $retval
	fi
	if [[ "$BUFFER" = "$orig_buffer"* && "$orig_postdisplay" = "${BUFFER:$#orig_buffer}"* ]]
	then
		POSTDISPLAY="${orig_postdisplay:$(($#BUFFER - $#orig_buffer))}" 
		return $retval
	fi
	if (( ${+_ZSH_AUTOSUGGEST_DISABLED} ))
	then
		return $?
	fi
	if (( $#BUFFER > 0 ))
	then
		if [[ -z "$ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE" ]] || (( $#BUFFER <= $ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE ))
		then
			_zsh_autosuggest_fetch
		fi
	fi
	return $retval
}
_zsh_autosuggest_partial_accept () {
	local -i retval cursor_loc
	local original_buffer="$BUFFER" 
	BUFFER="$BUFFER$POSTDISPLAY" 
	_zsh_autosuggest_invoke_original_widget $@
	retval=$? 
	cursor_loc=$CURSOR 
	if [[ "$KEYMAP" = "vicmd" ]]
	then
		cursor_loc=$((cursor_loc + 1)) 
	fi
	if (( $cursor_loc > $#original_buffer ))
	then
		POSTDISPLAY="${BUFFER[$(($cursor_loc + 1)),$#BUFFER]}" 
		BUFFER="${BUFFER[1,$cursor_loc]}" 
	else
		BUFFER="$original_buffer" 
	fi
	return $retval
}
_zsh_autosuggest_start () {
	if (( ${+ZSH_AUTOSUGGEST_MANUAL_REBIND} ))
	then
		add-zsh-hook -d precmd _zsh_autosuggest_start
	fi
	_zsh_autosuggest_bind_widgets
}
_zsh_autosuggest_strategy_completion () {
	emulate -L zsh
	setopt EXTENDED_GLOB
	typeset -g suggestion
	local line REPLY
	whence compdef > /dev/null || return
	zmodload zsh/zpty 2> /dev/null || return
	[[ -n "$ZSH_AUTOSUGGEST_COMPLETION_IGNORE" ]] && [[ "$1" == $~ZSH_AUTOSUGGEST_COMPLETION_IGNORE ]] && return
	if zle
	then
		zpty $ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME _zsh_autosuggest_capture_completion_sync
	else
		zpty $ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME _zsh_autosuggest_capture_completion_async "\$1"
		zpty -w $ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME $'\t'
	fi
	{
		zpty -r $ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME line '*'$'\0''*'$'\0'
		suggestion="${${(@0)line}[2]}" 
	} always {
		zpty -d $ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME
	}
}
_zsh_autosuggest_strategy_history () {
	emulate -L zsh
	setopt EXTENDED_GLOB
	local prefix="${1//(#m)[\\*?[\]<>()|^~#]/\\$MATCH}" 
	local pattern="$prefix*" 
	if [[ -n $ZSH_AUTOSUGGEST_HISTORY_IGNORE ]]
	then
		pattern="($pattern)~($ZSH_AUTOSUGGEST_HISTORY_IGNORE)" 
	fi
	typeset -g suggestion="${history[(r)$pattern]}" 
}
_zsh_autosuggest_strategy_match_prev_cmd () {
	emulate -L zsh
	setopt EXTENDED_GLOB
	local prefix="${1//(#m)[\\*?[\]<>()|^~#]/\\$MATCH}" 
	local pattern="$prefix*" 
	if [[ -n $ZSH_AUTOSUGGEST_HISTORY_IGNORE ]]
	then
		pattern="($pattern)~($ZSH_AUTOSUGGEST_HISTORY_IGNORE)" 
	fi
	local history_match_keys
	history_match_keys=(${(k)history[(R)$~pattern]}) 
	local histkey="${history_match_keys[1]}" 
	local prev_cmd="$(_zsh_autosuggest_escape_command "${history[$((HISTCMD-1))]}")" 
	for key in "${(@)history_match_keys[1,200]}"
	do
		[[ $key -gt 1 ]] || break
		if [[ "${history[$((key - 1))]}" == "$prev_cmd" ]]
		then
			histkey="$key" 
			break
		fi
	done
	typeset -g suggestion="$history[$histkey]" 
}
_zsh_autosuggest_suggest () {
	emulate -L zsh
	local suggestion="$1" 
	if [[ -n "$suggestion" ]] && (( $#BUFFER ))
	then
		POSTDISPLAY="${suggestion#$BUFFER}" 
	else
		POSTDISPLAY= 
	fi
}
_zsh_autosuggest_toggle () {
	if (( ${+_ZSH_AUTOSUGGEST_DISABLED} ))
	then
		_zsh_autosuggest_enable
	else
		_zsh_autosuggest_disable
	fi
}
_zsh_autosuggest_widget_accept () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_accept $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_clear () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_clear $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_disable () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_disable $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_enable () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_enable $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_execute () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_execute $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_fetch () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_fetch $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_modify () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_modify $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_partial_accept () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_partial_accept $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_suggest () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_suggest $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_toggle () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_toggle $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_highlight () {
	local ret=$? 
	if [[ $WIDGET == zle-isearch-update ]] && ! (( $+ISEARCHMATCH_ACTIVE ))
	then
		region_highlight=() 
		return $ret
	fi
	emulate -LR zsh
	setopt extendedglob warncreateglobal typesetsilent noshortloops
	local REPLY
	local -a reply
	[[ -n ${ZSH_HIGHLIGHT_MAXLENGTH:-} ]] && [[ $#BUFFER -gt $ZSH_HIGHLIGHT_MAXLENGTH ]] && return $ret
	[[ $PENDING -gt 0 ]] && return $ret
	if [[ $WIDGET == zle-line-finish ]] || _zsh_highlight_buffer_modified
	then
		-fast-highlight-init
		-fast-highlight-process "$PREBUFFER" "$BUFFER" 0
		(( FAST_HIGHLIGHT[use_brackets] )) && {
			_FAST_MAIN_CACHE=($reply) 
			-fast-highlight-string-process "$PREBUFFER" "$BUFFER"
		}
		region_highlight=($reply) 
	else
		local char="${BUFFER[CURSOR+1]}" 
		if [[ "$char" = ["{([])}"] || "${FAST_HIGHLIGHT[prev_char]}" = ["{([])}"] ]]
		then
			FAST_HIGHLIGHT[prev_char]="$char" 
			(( FAST_HIGHLIGHT[use_brackets] )) && {
				reply=($_FAST_MAIN_CACHE) 
				-fast-highlight-string-process "$PREBUFFER" "$BUFFER"
				region_highlight=($reply) 
			}
		fi
	fi
	{
		local cache_place
		local -a region_highlight_copy
		if (( REGION_ACTIVE == 1 ))
		then
			_zsh_highlight_apply_zle_highlight region standout "$MARK" "$CURSOR"
		elif (( REGION_ACTIVE == 2 ))
		then
			() {
				local needle=$'\n' 
				integer min max
				if (( MARK > CURSOR ))
				then
					min=$CURSOR max=$(( MARK + 1 )) 
				else
					min=$MARK max=$CURSOR 
				fi
				(( min = ${${BUFFER[1,$min]}[(I)$needle]} ))
				(( max += ${${BUFFER:($max-1)}[(i)$needle]} - 1 ))
				_zsh_highlight_apply_zle_highlight region standout "$min" "$max"
			}
		fi
		(( $+YANK_ACTIVE )) && (( YANK_ACTIVE )) && _zsh_highlight_apply_zle_highlight paste standout "$YANK_START" "$YANK_END"
		(( $+ISEARCHMATCH_ACTIVE )) && (( ISEARCHMATCH_ACTIVE )) && _zsh_highlight_apply_zle_highlight isearch underline "$ISEARCHMATCH_START" "$ISEARCHMATCH_END"
		(( $+SUFFIX_ACTIVE )) && (( SUFFIX_ACTIVE )) && _zsh_highlight_apply_zle_highlight suffix bold "$SUFFIX_START" "$SUFFIX_END"
		return $ret
	} always {
		typeset -g _ZSH_HIGHLIGHT_PRIOR_BUFFER="$BUFFER" 
		typeset -g _ZSH_HIGHLIGHT_PRIOR_RACTIVE="$REGION_ACTIVE" 
		typeset -gi _ZSH_HIGHLIGHT_PRIOR_CURSOR=$CURSOR 
	}
}
_zsh_highlight_apply_zle_highlight () {
	local entry="$1" default="$2" 
	integer first="$3" second="$4" 
	local region="${zle_highlight[(r)${entry}:*]}" 
	if [[ -z "$region" ]]
	then
		region=$default 
	else
		region="${region#${entry}:}" 
		if [[ -z "$region" ]] || [[ "$region" == none ]]
		then
			return
		fi
	fi
	integer start end
	if (( first < second ))
	then
		start=$first end=$second 
	else
		start=$second end=$first 
	fi
	region_highlight+=("$start $end $region") 
}
_zsh_highlight_bind_widgets () {
	setopt localoptions noksharrays
	local -F2 SECONDS
	local prefix=orig-s${SECONDS/./}-r$(( RANDOM % 1000 )) 
	zmodload zsh/zleparameter 2> /dev/null || {
		print -r -- 'zsh-syntax-highlighting: failed loading zsh/zleparameter.' >&2
		return 1
	}
	local -U widgets_to_bind
	widgets_to_bind=(${${(k)widgets}:#(.*|run-help|which-command|beep|set-local-history|yank|zle-line-pre-redraw|zle-keymap-select)}) 
	widgets_to_bind+=(zle-line-finish) 
	widgets_to_bind+=(zle-isearch-update) 
	local cur_widget
	for cur_widget in $widgets_to_bind
	do
		case ${widgets[$cur_widget]-} in
			(user:_zsh_highlight_widget_*)  ;;
			(user:*) zle -N -- $prefix-$cur_widget ${widgets[$cur_widget]#*:}
				eval "_zsh_highlight_widget_${(q)prefix}-${(q)cur_widget}() { _zsh_highlight_call_widget ${(q)prefix}-${(q)cur_widget} -- \"\$@\" }"
				zle -N -- $cur_widget _zsh_highlight_widget_$prefix-$cur_widget ;;
			(completion:*) zle -C $prefix-$cur_widget ${${(s.:.)widgets[$cur_widget]}[2,3]}
				eval "_zsh_highlight_widget_${(q)prefix}-${(q)cur_widget}() { _zsh_highlight_call_widget ${(q)prefix}-${(q)cur_widget} -- \"\$@\" }"
				zle -N -- $cur_widget _zsh_highlight_widget_$prefix-$cur_widget ;;
			(builtin) eval "_zsh_highlight_widget_${(q)prefix}-${(q)cur_widget}() { _zsh_highlight_call_widget .${(q)cur_widget} -- \"\$@\" }"
				zle -N -- $cur_widget _zsh_highlight_widget_$prefix-$cur_widget ;;
			(*) if [[ $cur_widget == zle-* ]] && [[ -z ${widgets[$cur_widget]-} ]]
				then
					_zsh_highlight_widget_${cur_widget} () {
						:
						_zsh_highlight
					}
					zle -N -- $cur_widget _zsh_highlight_widget_$cur_widget
				else
					print -r -- "zsh-syntax-highlighting: unhandled ZLE widget ${(qq)cur_widget}" >&2
				fi ;;
		esac
	done
}
_zsh_highlight_buffer_modified () {
	[[ "${_ZSH_HIGHLIGHT_PRIOR_BUFFER:-}" != "$BUFFER" ]] || [[ "$REGION_ACTIVE" != "$_ZSH_HIGHLIGHT_PRIOR_RACTIVE" ]] || {
		_zsh_highlight_cursor_moved && [[ "$REGION_ACTIVE" = 1 || "$REGION_ACTIVE" = 2 ]]
	}
}
_zsh_highlight_call_widget () {
	integer ret
	builtin zle "$@"
	ret=$? 
	_zsh_highlight
	return $ret
}
_zsh_highlight_cursor_moved () {
	[[ -n $CURSOR ]] && [[ -n ${_ZSH_HIGHLIGHT_PRIOR_CURSOR-} ]] && (($_ZSH_HIGHLIGHT_PRIOR_CURSOR != $CURSOR))
}
_zsh_highlight_preexec_hook () {
	typeset -g _ZSH_HIGHLIGHT_PRIOR_BUFFER= 
	typeset -gi _ZSH_HIGHLIGHT_PRIOR_CURSOR=0 
	typeset -ga _FAST_MAIN_CACHE
	_FAST_MAIN_CACHE=() 
}
_zsh_highlight_widget_orig-s000-r302-_bash_complete-word () {
	_zsh_highlight_call_widget orig-s000-r302-_bash_complete-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-_bash_list-choices () {
	_zsh_highlight_call_widget orig-s000-r302-_bash_list-choices -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-_complete_debug () {
	_zsh_highlight_call_widget orig-s000-r302-_complete_debug -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-_complete_help () {
	_zsh_highlight_call_widget orig-s000-r302-_complete_help -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-_complete_tag () {
	_zsh_highlight_call_widget orig-s000-r302-_complete_tag -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-_correct_filename () {
	_zsh_highlight_call_widget orig-s000-r302-_correct_filename -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-_correct_word () {
	_zsh_highlight_call_widget orig-s000-r302-_correct_word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-_expand_alias () {
	_zsh_highlight_call_widget orig-s000-r302-_expand_alias -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-_expand_word () {
	_zsh_highlight_call_widget orig-s000-r302-_expand_word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-_fzf-tab-apply () {
	_zsh_highlight_call_widget orig-s000-r302-_fzf-tab-apply -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-_history-complete-newer () {
	_zsh_highlight_call_widget orig-s000-r302-_history-complete-newer -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-_history-complete-older () {
	_zsh_highlight_call_widget orig-s000-r302-_history-complete-older -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-_list_expansions () {
	_zsh_highlight_call_widget orig-s000-r302-_list_expansions -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-_most_recent_file () {
	_zsh_highlight_call_widget orig-s000-r302-_most_recent_file -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-_next_tags () {
	_zsh_highlight_call_widget orig-s000-r302-_next_tags -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-_read_comp () {
	_zsh_highlight_call_widget orig-s000-r302-_read_comp -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-accept-and-hold () {
	_zsh_highlight_call_widget .accept-and-hold -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-accept-and-infer-next-history () {
	_zsh_highlight_call_widget .accept-and-infer-next-history -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-accept-and-menu-complete () {
	_zsh_highlight_call_widget .accept-and-menu-complete -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-accept-line () {
	_zsh_highlight_call_widget .accept-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-accept-line-and-down-history () {
	_zsh_highlight_call_widget .accept-line-and-down-history -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-accept-search () {
	_zsh_highlight_call_widget .accept-search -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-argument-base () {
	_zsh_highlight_call_widget .argument-base -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-auto-suffix-remove () {
	_zsh_highlight_call_widget .auto-suffix-remove -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-auto-suffix-retain () {
	_zsh_highlight_call_widget .auto-suffix-retain -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-backward-char () {
	_zsh_highlight_call_widget .backward-char -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-backward-delete-char () {
	_zsh_highlight_call_widget .backward-delete-char -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-backward-delete-word () {
	_zsh_highlight_call_widget .backward-delete-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-backward-kill-line () {
	_zsh_highlight_call_widget .backward-kill-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-backward-kill-word () {
	_zsh_highlight_call_widget .backward-kill-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-backward-word () {
	_zsh_highlight_call_widget .backward-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-beginning-of-buffer-or-history () {
	_zsh_highlight_call_widget .beginning-of-buffer-or-history -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-beginning-of-history () {
	_zsh_highlight_call_widget .beginning-of-history -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-beginning-of-line () {
	_zsh_highlight_call_widget .beginning-of-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-beginning-of-line-hist () {
	_zsh_highlight_call_widget .beginning-of-line-hist -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-bracketed-paste () {
	_zsh_highlight_call_widget .bracketed-paste -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-capitalize-word () {
	_zsh_highlight_call_widget .capitalize-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-clear-screen () {
	_zsh_highlight_call_widget .clear-screen -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-complete-word () {
	_zsh_highlight_call_widget orig-s000-r302-complete-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-copy-prev-shell-word () {
	_zsh_highlight_call_widget .copy-prev-shell-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-copy-prev-word () {
	_zsh_highlight_call_widget .copy-prev-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-copy-region-as-kill () {
	_zsh_highlight_call_widget .copy-region-as-kill -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-deactivate-region () {
	_zsh_highlight_call_widget .deactivate-region -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-delete-char () {
	_zsh_highlight_call_widget .delete-char -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-delete-char-or-list () {
	_zsh_highlight_call_widget orig-s000-r302-delete-char-or-list -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-delete-word () {
	_zsh_highlight_call_widget .delete-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-describe-key-briefly () {
	_zsh_highlight_call_widget .describe-key-briefly -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-digit-argument () {
	_zsh_highlight_call_widget .digit-argument -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-down-case-word () {
	_zsh_highlight_call_widget .down-case-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-down-history () {
	_zsh_highlight_call_widget .down-history -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-down-line () {
	_zsh_highlight_call_widget .down-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-down-line-or-history () {
	_zsh_highlight_call_widget .down-line-or-history -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-down-line-or-search () {
	_zsh_highlight_call_widget .down-line-or-search -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-emacs-backward-word () {
	_zsh_highlight_call_widget .emacs-backward-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-emacs-forward-word () {
	_zsh_highlight_call_widget .emacs-forward-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-end-of-buffer-or-history () {
	_zsh_highlight_call_widget .end-of-buffer-or-history -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-end-of-history () {
	_zsh_highlight_call_widget .end-of-history -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-end-of-line () {
	_zsh_highlight_call_widget .end-of-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-end-of-line-hist () {
	_zsh_highlight_call_widget .end-of-line-hist -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-end-of-list () {
	_zsh_highlight_call_widget .end-of-list -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-exchange-point-and-mark () {
	_zsh_highlight_call_widget .exchange-point-and-mark -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-execute-last-named-cmd () {
	_zsh_highlight_call_widget .execute-last-named-cmd -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-execute-named-cmd () {
	_zsh_highlight_call_widget .execute-named-cmd -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-expand-cmd-path () {
	_zsh_highlight_call_widget .expand-cmd-path -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-expand-history () {
	_zsh_highlight_call_widget .expand-history -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-expand-or-complete () {
	_zsh_highlight_call_widget orig-s000-r302-expand-or-complete -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-expand-or-complete-prefix () {
	_zsh_highlight_call_widget orig-s000-r302-expand-or-complete-prefix -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-expand-word () {
	_zsh_highlight_call_widget .expand-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-forward-char () {
	_zsh_highlight_call_widget .forward-char -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-forward-word () {
	_zsh_highlight_call_widget .forward-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-fzf-tab-complete () {
	_zsh_highlight_call_widget orig-s000-r302-fzf-tab-complete -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-fzf-tab-debug () {
	_zsh_highlight_call_widget orig-s000-r302-fzf-tab-debug -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-fzf-tab-dummy () {
	_zsh_highlight_call_widget orig-s000-r302-fzf-tab-dummy -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-get-line () {
	_zsh_highlight_call_widget .get-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-gosmacs-transpose-chars () {
	_zsh_highlight_call_widget .gosmacs-transpose-chars -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-history-beginning-search-backward () {
	_zsh_highlight_call_widget .history-beginning-search-backward -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-history-beginning-search-forward () {
	_zsh_highlight_call_widget .history-beginning-search-forward -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-history-incremental-pattern-search-backward () {
	_zsh_highlight_call_widget .history-incremental-pattern-search-backward -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-history-incremental-pattern-search-forward () {
	_zsh_highlight_call_widget .history-incremental-pattern-search-forward -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-history-incremental-search-backward () {
	_zsh_highlight_call_widget .history-incremental-search-backward -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-history-incremental-search-forward () {
	_zsh_highlight_call_widget .history-incremental-search-forward -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-history-search-backward () {
	_zsh_highlight_call_widget .history-search-backward -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-history-search-forward () {
	_zsh_highlight_call_widget .history-search-forward -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-infer-next-history () {
	_zsh_highlight_call_widget .infer-next-history -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-insert-last-word () {
	_zsh_highlight_call_widget .insert-last-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-kill-buffer () {
	_zsh_highlight_call_widget .kill-buffer -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-kill-line () {
	_zsh_highlight_call_widget .kill-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-kill-region () {
	_zsh_highlight_call_widget .kill-region -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-kill-whole-line () {
	_zsh_highlight_call_widget .kill-whole-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-kill-word () {
	_zsh_highlight_call_widget .kill-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-list-choices () {
	_zsh_highlight_call_widget orig-s000-r302-list-choices -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-list-expand () {
	_zsh_highlight_call_widget .list-expand -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-magic-space () {
	_zsh_highlight_call_widget .magic-space -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-menu-complete () {
	_zsh_highlight_call_widget orig-s000-r302-menu-complete -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-menu-expand-or-complete () {
	_zsh_highlight_call_widget orig-s000-r302-menu-expand-or-complete -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-neg-argument () {
	_zsh_highlight_call_widget .neg-argument -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-overwrite-mode () {
	_zsh_highlight_call_widget .overwrite-mode -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-pound-insert () {
	_zsh_highlight_call_widget .pound-insert -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-push-input () {
	_zsh_highlight_call_widget .push-input -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-push-line () {
	_zsh_highlight_call_widget .push-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-push-line-or-edit () {
	_zsh_highlight_call_widget .push-line-or-edit -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-put-replace-selection () {
	_zsh_highlight_call_widget .put-replace-selection -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-quote-line () {
	_zsh_highlight_call_widget .quote-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-quote-region () {
	_zsh_highlight_call_widget .quote-region -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-quoted-insert () {
	_zsh_highlight_call_widget .quoted-insert -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-read-command () {
	_zsh_highlight_call_widget .read-command -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-recursive-edit () {
	_zsh_highlight_call_widget .recursive-edit -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-redisplay () {
	_zsh_highlight_call_widget .redisplay -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-redo () {
	_zsh_highlight_call_widget .redo -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-reset-prompt () {
	_zsh_highlight_call_widget .reset-prompt -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-reverse-menu-complete () {
	_zsh_highlight_call_widget orig-s000-r302-reverse-menu-complete -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-select-a-blank-word () {
	_zsh_highlight_call_widget .select-a-blank-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-select-a-shell-word () {
	_zsh_highlight_call_widget .select-a-shell-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-select-a-word () {
	_zsh_highlight_call_widget .select-a-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-select-in-blank-word () {
	_zsh_highlight_call_widget .select-in-blank-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-select-in-shell-word () {
	_zsh_highlight_call_widget .select-in-shell-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-select-in-word () {
	_zsh_highlight_call_widget .select-in-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-self-insert () {
	_zsh_highlight_call_widget .self-insert -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-self-insert-unmeta () {
	_zsh_highlight_call_widget .self-insert-unmeta -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-send-break () {
	_zsh_highlight_call_widget .send-break -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-sesh-sessions () {
	_zsh_highlight_call_widget orig-s000-r302-sesh-sessions -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-set-mark-command () {
	_zsh_highlight_call_widget .set-mark-command -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-spell-word () {
	_zsh_highlight_call_widget .spell-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-split-undo () {
	_zsh_highlight_call_widget .split-undo -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-toggle-fzf-tab () {
	_zsh_highlight_call_widget orig-s000-r302-toggle-fzf-tab -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-transpose-chars () {
	_zsh_highlight_call_widget .transpose-chars -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-transpose-words () {
	_zsh_highlight_call_widget .transpose-words -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-undefined-key () {
	_zsh_highlight_call_widget .undefined-key -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-undo () {
	_zsh_highlight_call_widget .undo -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-universal-argument () {
	_zsh_highlight_call_widget .universal-argument -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-up-case-word () {
	_zsh_highlight_call_widget .up-case-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-up-history () {
	_zsh_highlight_call_widget .up-history -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-up-line () {
	_zsh_highlight_call_widget .up-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-up-line-or-history () {
	_zsh_highlight_call_widget .up-line-or-history -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-up-line-or-search () {
	_zsh_highlight_call_widget .up-line-or-search -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-add-eol () {
	_zsh_highlight_call_widget .vi-add-eol -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-add-next () {
	_zsh_highlight_call_widget .vi-add-next -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-backward-blank-word () {
	_zsh_highlight_call_widget .vi-backward-blank-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-backward-blank-word-end () {
	_zsh_highlight_call_widget .vi-backward-blank-word-end -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-backward-char () {
	_zsh_highlight_call_widget .vi-backward-char -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-backward-delete-char () {
	_zsh_highlight_call_widget .vi-backward-delete-char -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-backward-kill-word () {
	_zsh_highlight_call_widget .vi-backward-kill-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-backward-word () {
	_zsh_highlight_call_widget .vi-backward-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-backward-word-end () {
	_zsh_highlight_call_widget .vi-backward-word-end -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-beginning-of-line () {
	_zsh_highlight_call_widget .vi-beginning-of-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-caps-lock-panic () {
	_zsh_highlight_call_widget .vi-caps-lock-panic -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-change () {
	_zsh_highlight_call_widget .vi-change -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-change-eol () {
	_zsh_highlight_call_widget .vi-change-eol -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-change-whole-line () {
	_zsh_highlight_call_widget .vi-change-whole-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-cmd-mode () {
	_zsh_highlight_call_widget .vi-cmd-mode -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-delete () {
	_zsh_highlight_call_widget .vi-delete -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-delete-char () {
	_zsh_highlight_call_widget .vi-delete-char -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-digit-or-beginning-of-line () {
	_zsh_highlight_call_widget .vi-digit-or-beginning-of-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-down-case () {
	_zsh_highlight_call_widget .vi-down-case -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-down-line-or-history () {
	_zsh_highlight_call_widget .vi-down-line-or-history -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-end-of-line () {
	_zsh_highlight_call_widget .vi-end-of-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-fetch-history () {
	_zsh_highlight_call_widget .vi-fetch-history -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-find-next-char () {
	_zsh_highlight_call_widget .vi-find-next-char -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-find-next-char-skip () {
	_zsh_highlight_call_widget .vi-find-next-char-skip -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-find-prev-char () {
	_zsh_highlight_call_widget .vi-find-prev-char -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-find-prev-char-skip () {
	_zsh_highlight_call_widget .vi-find-prev-char-skip -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-first-non-blank () {
	_zsh_highlight_call_widget .vi-first-non-blank -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-forward-blank-word () {
	_zsh_highlight_call_widget .vi-forward-blank-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-forward-blank-word-end () {
	_zsh_highlight_call_widget .vi-forward-blank-word-end -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-forward-char () {
	_zsh_highlight_call_widget .vi-forward-char -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-forward-word () {
	_zsh_highlight_call_widget .vi-forward-word -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-forward-word-end () {
	_zsh_highlight_call_widget .vi-forward-word-end -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-goto-column () {
	_zsh_highlight_call_widget .vi-goto-column -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-goto-mark () {
	_zsh_highlight_call_widget .vi-goto-mark -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-goto-mark-line () {
	_zsh_highlight_call_widget .vi-goto-mark-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-history-search-backward () {
	_zsh_highlight_call_widget .vi-history-search-backward -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-history-search-forward () {
	_zsh_highlight_call_widget .vi-history-search-forward -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-indent () {
	_zsh_highlight_call_widget .vi-indent -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-insert () {
	_zsh_highlight_call_widget .vi-insert -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-insert-bol () {
	_zsh_highlight_call_widget .vi-insert-bol -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-join () {
	_zsh_highlight_call_widget .vi-join -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-kill-eol () {
	_zsh_highlight_call_widget .vi-kill-eol -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-kill-line () {
	_zsh_highlight_call_widget .vi-kill-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-match-bracket () {
	_zsh_highlight_call_widget .vi-match-bracket -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-open-line-above () {
	_zsh_highlight_call_widget .vi-open-line-above -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-open-line-below () {
	_zsh_highlight_call_widget .vi-open-line-below -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-oper-swap-case () {
	_zsh_highlight_call_widget .vi-oper-swap-case -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-pound-insert () {
	_zsh_highlight_call_widget .vi-pound-insert -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-put-after () {
	_zsh_highlight_call_widget .vi-put-after -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-put-before () {
	_zsh_highlight_call_widget .vi-put-before -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-quoted-insert () {
	_zsh_highlight_call_widget .vi-quoted-insert -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-repeat-change () {
	_zsh_highlight_call_widget .vi-repeat-change -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-repeat-find () {
	_zsh_highlight_call_widget .vi-repeat-find -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-repeat-search () {
	_zsh_highlight_call_widget .vi-repeat-search -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-replace () {
	_zsh_highlight_call_widget .vi-replace -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-replace-chars () {
	_zsh_highlight_call_widget .vi-replace-chars -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-rev-repeat-find () {
	_zsh_highlight_call_widget .vi-rev-repeat-find -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-rev-repeat-search () {
	_zsh_highlight_call_widget .vi-rev-repeat-search -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-set-buffer () {
	_zsh_highlight_call_widget .vi-set-buffer -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-set-mark () {
	_zsh_highlight_call_widget .vi-set-mark -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-substitute () {
	_zsh_highlight_call_widget .vi-substitute -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-swap-case () {
	_zsh_highlight_call_widget .vi-swap-case -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-undo-change () {
	_zsh_highlight_call_widget .vi-undo-change -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-unindent () {
	_zsh_highlight_call_widget .vi-unindent -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-up-case () {
	_zsh_highlight_call_widget .vi-up-case -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-up-line-or-history () {
	_zsh_highlight_call_widget .vi-up-line-or-history -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-yank () {
	_zsh_highlight_call_widget .vi-yank -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-yank-eol () {
	_zsh_highlight_call_widget .vi-yank-eol -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-vi-yank-whole-line () {
	_zsh_highlight_call_widget .vi-yank-whole-line -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-visual-line-mode () {
	_zsh_highlight_call_widget .visual-line-mode -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-visual-mode () {
	_zsh_highlight_call_widget .visual-mode -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-what-cursor-position () {
	_zsh_highlight_call_widget .what-cursor-position -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-where-is () {
	_zsh_highlight_call_widget .where-is -- "$@"
}
_zsh_highlight_widget_orig-s000-r302-yank-pop () {
	_zsh_highlight_call_widget .yank-pop -- "$@"
}
_zsh_highlight_widget_zle-isearch-update () {
	:
	_zsh_highlight
}
_zsh_highlight_widget_zle-line-finish () {
	:
	_zsh_highlight
}
_zsocket () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zstyle () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_ztodo () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
_zypper () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
add-zsh-hook () {
	emulate -L zsh
	local -a hooktypes
	hooktypes=(chpwd precmd preexec periodic zshaddhistory zshexit zsh_directory_name) 
	local usage="Usage: add-zsh-hook hook function\nValid hooks are:\n  $hooktypes" 
	local opt
	local -a autoopts
	integer del list help
	while getopts "dDhLUzk" opt
	do
		case $opt in
			(d) del=1  ;;
			(D) del=2  ;;
			(h) help=1  ;;
			(L) list=1  ;;
			([Uzk]) autoopts+=(-$opt)  ;;
			(*) return 1 ;;
		esac
	done
	shift $(( OPTIND - 1 ))
	if (( list ))
	then
		typeset -mp "(${1:-${(@j:|:)hooktypes}})_functions"
		return $?
	elif (( help || $# != 2 || ${hooktypes[(I)$1]} == 0 ))
	then
		print -u$(( 2 - help )) $usage
		return $(( 1 - help ))
	fi
	local hook="${1}_functions" 
	local fn="$2" 
	if (( del ))
	then
		if (( ${(P)+hook} ))
		then
			if (( del == 2 ))
			then
				set -A $hook ${(P)hook:#${~fn}}
			else
				set -A $hook ${(P)hook:#$fn}
			fi
			if (( ! ${(P)#hook} ))
			then
				unset $hook
			fi
		fi
	else
		if (( ${(P)+hook} ))
		then
			if (( ${${(P)hook}[(I)$fn]} == 0 ))
			then
				typeset -ga $hook
				set -A $hook ${(P)hook} $fn
			fi
		else
			typeset -ga $hook
			set -A $hook $fn
		fi
		autoload $autoopts -- $fn
	fi
}
brew () {
	command brew "$@"
	if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]] || [[ $* =~ "list" ]] || [[ $* =~ "install" ]] || [[ $* =~ "uninstall" ]] || [[ $* =~ "bundle" ]] || [[ $* =~ "doctor" ]] || [[ $* =~ "info" ]] || [[ $* =~ "cleanup" ]]
	then
		sketchybar --trigger brew_update
	fi
}
build-fzf-tab-module () {
	{
		pushd -q $FZF_TAB_HOME/modules
		if -ftb-build-module $@
		then
			print -P "%F{green}%BThe module has been built successfully. Please restart zsh to apply it.%f%b"
		else
			print -P -u2 "%F{red}%BThe module building has failed. See the output above for details.%f%b"
			return 1
		fi
	} always {
		popd -q
	}
}
compadd () {
	local -A apre hpre dscrs _oad _mesg
	local -a isfile _opts __ expl
	zparseopts -a _opts P:=apre p:=hpre d:=dscrs X+:=expl O:=_oad A:=_oad D:=_oad f=isfile i: S: s: I: x:=_mesg r: R: W: F: M+: E: q e Q n U C J:=__ V:=__ a=__ l=__ k=__ o::=__ 1=__ 2=__
	_ftb_curcontext=${curcontext#:} 
	if (( $#_oad != 0 || ! IN_FZF_TAB )) || {
			-ftb-zstyle -m disabled-on "any"
		} || {
			-ftb-zstyle -m disabled-on "files" && [[ -n $isfile ]]
		}
	then
		builtin compadd "$@"
		return
	fi
	local -a __hits __dscr
	if (( $#dscrs == 1 ))
	then
		__dscr=("${(@P)${(v)dscrs}}") 
	fi
	builtin compadd -A __hits -D __dscr "$@"
	local ret=$? 
	if (( $#__hits == 0 ))
	then
		if is-at-least 5.9 && (( $#_mesg != 0 ))
		then
			builtin compadd -x $_mesg
		fi
		return $ret
	fi
	expl=$expl[2] 
	[[ -n $expl ]] && _ftb_groups+=$expl 
	local -a keys=(apre hpre PREFIX SUFFIX IPREFIX ISUFFIX) 
	local key expanded __tmp_value=$'<\0>' 
	for key in $keys
	do
		expanded=${(P)key} 
		if [[ -n $expanded ]]
		then
			__tmp_value+=$'\0'$key$'\0'$expanded 
		fi
	done
	if [[ -n $expl ]]
	then
		__tmp_value+=$'\0group\0'$_ftb_groups[(ie)$expl] 
	fi
	if [[ -n $isfile ]]
	then
		__tmp_value+=$'\0realdir\0'${${(Qe)~${:-$IPREFIX$hpre}}} 
	fi
	_opts+=("${(@kv)apre}" "${(@kv)hpre}" $isfile) 
	__tmp_value+=$'\0args\0'${(pj:\1:)_opts} 
	if (( $+builtins[fzf-tab-compcap-generate] ))
	then
		fzf-tab-compcap-generate __hits __dscr __tmp_value
	else
		local dscr word i
		for i in {1..$#__hits}
		do
			word=$__hits[i] dscr=$__dscr[i] 
			if [[ -n $dscr ]]
			then
				dscr=${dscr//$'\n'} 
			elif [[ -n $word ]]
			then
				dscr=$word 
			fi
			_ftb_compcap+=$dscr$'\2'$__tmp_value$'\0word\0'$word 
		done
	fi
	builtin compadd "$@"
}
compaudit () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
compdef () {
	local opt autol type func delete eval new i ret=0 cmd svc 
	local -a match mbegin mend
	emulate -L zsh
	setopt extendedglob
	if (( ! $# ))
	then
		print -u2 "$0: I need arguments"
		return 1
	fi
	while getopts "anpPkKde" opt
	do
		case "$opt" in
			(a) autol=yes  ;;
			(n) new=yes  ;;
			([pPkK]) if [[ -n "$type" ]]
				then
					print -u2 "$0: type already set to $type"
					return 1
				fi
				if [[ "$opt" = p ]]
				then
					type=pattern 
				elif [[ "$opt" = P ]]
				then
					type=postpattern 
				elif [[ "$opt" = K ]]
				then
					type=widgetkey 
				else
					type=key 
				fi ;;
			(d) delete=yes  ;;
			(e) eval=yes  ;;
		esac
	done
	shift OPTIND-1
	if (( ! $# ))
	then
		print -u2 "$0: I need arguments"
		return 1
	fi
	if [[ -z "$delete" ]]
	then
		if [[ -z "$eval" ]] && [[ "$1" = *\=* ]]
		then
			while (( $# ))
			do
				if [[ "$1" = *\=* ]]
				then
					cmd="${1%%\=*}" 
					svc="${1#*\=}" 
					func="$_comps[${_services[(r)$svc]:-$svc}]" 
					[[ -n ${_services[$svc]} ]] && svc=${_services[$svc]} 
					[[ -z "$func" ]] && func="${${_patcomps[(K)$svc][1]}:-${_postpatcomps[(K)$svc][1]}}" 
					if [[ -n "$func" ]]
					then
						_comps[$cmd]="$func" 
						_services[$cmd]="$svc" 
					else
						print -u2 "$0: unknown command or service: $svc"
						ret=1 
					fi
				else
					print -u2 "$0: invalid argument: $1"
					ret=1 
				fi
				shift
			done
			return ret
		fi
		func="$1" 
		[[ -n "$autol" ]] && autoload -rUz "$func"
		shift
		case "$type" in
			(widgetkey) while [[ -n $1 ]]
				do
					if [[ $# -lt 3 ]]
					then
						print -u2 "$0: compdef -K requires <widget> <comp-widget> <key>"
						return 1
					fi
					[[ $1 = _* ]] || 1="_$1" 
					[[ $2 = .* ]] || 2=".$2" 
					[[ $2 = .menu-select ]] && zmodload -i zsh/complist
					zle -C "$1" "$2" "$func"
					if [[ -n $new ]]
					then
						bindkey "$3" | IFS=$' \t' read -A opt
						[[ $opt[-1] = undefined-key ]] && bindkey "$3" "$1"
					else
						bindkey "$3" "$1"
					fi
					shift 3
				done ;;
			(key) if [[ $# -lt 2 ]]
				then
					print -u2 "$0: missing keys"
					return 1
				fi
				if [[ $1 = .* ]]
				then
					[[ $1 = .menu-select ]] && zmodload -i zsh/complist
					zle -C "$func" "$1" "$func"
				else
					[[ $1 = menu-select ]] && zmodload -i zsh/complist
					zle -C "$func" ".$1" "$func"
				fi
				shift
				for i
				do
					if [[ -n $new ]]
					then
						bindkey "$i" | IFS=$' \t' read -A opt
						[[ $opt[-1] = undefined-key ]] || continue
					fi
					bindkey "$i" "$func"
				done ;;
			(*) while (( $# ))
				do
					if [[ "$1" = -N ]]
					then
						type=normal 
					elif [[ "$1" = -p ]]
					then
						type=pattern 
					elif [[ "$1" = -P ]]
					then
						type=postpattern 
					else
						case "$type" in
							(pattern) if [[ $1 = (#b)(*)=(*) ]]
								then
									_patcomps[$match[1]]="=$match[2]=$func" 
								else
									_patcomps[$1]="$func" 
								fi ;;
							(postpattern) if [[ $1 = (#b)(*)=(*) ]]
								then
									_postpatcomps[$match[1]]="=$match[2]=$func" 
								else
									_postpatcomps[$1]="$func" 
								fi ;;
							(*) if [[ "$1" = *\=* ]]
								then
									cmd="${1%%\=*}" 
									svc=yes 
								else
									cmd="$1" 
									svc= 
								fi
								if [[ -z "$new" || -z "${_comps[$1]}" ]]
								then
									_comps[$cmd]="$func" 
									[[ -n "$svc" ]] && _services[$cmd]="${1#*\=}" 
								fi ;;
						esac
					fi
					shift
				done ;;
		esac
	else
		case "$type" in
			(pattern) unset "_patcomps[$^@]" ;;
			(postpattern) unset "_postpatcomps[$^@]" ;;
			(key) print -u2 "$0: cannot restore key bindings"
				return 1 ;;
			(*) unset "_comps[$^@]" ;;
		esac
	fi
}
compdump () {
	# undefined
	builtin autoload -XUz
}
compinit () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
compinstall () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
disable-fzf-tab () {
	emulate -L zsh -o extended_glob
	(( $+_ftb_orig_widget )) || return 0
	bindkey '^I' $_ftb_orig_widget
	case $_ftb_orig_list_grouped in
		(0) zstyle ':completion:*' list-grouped false ;;
		(1) zstyle ':completion:*' list-grouped true ;;
		(2) zstyle -d ':completion:*' list-grouped ;;
	esac
	unset _ftb_orig_widget _ftb_orig_list_groupded
	unfunction compadd 2> /dev/null
	functions[_main_complete]=$functions[_ftb__main_complete] 
	functions[_approximate]=$functions[_ftb__approximate] 
}
enable-fzf-tab () {
	emulate -L zsh -o extended_glob
	(( ! $+_ftb_orig_widget )) || disable-fzf-tab
	typeset -g _ftb_orig_widget="${${$(builtin bindkey '^I')##* }:-expand-or-complete}" 
	if (( ! $+widgets[.fzf-tab-orig-$_ftb_orig_widget] ))
	then
		local compinit_widgets=(complete-word delete-char-or-list expand-or-complete expand-or-complete-prefix list-choices menu-complete menu-expand-or-complete reverse-menu-complete) 
		if [[ $widgets[$_ftb_orig_widget] == builtin && $compinit_widgets[(Ie)$_ftb_orig_widget] != 0 ]]
		then
			zle -C .fzf-tab-orig-$_ftb_orig_widget .$_ftb_orig_widget _main_complete
		else
			zle -A $_ftb_orig_widget .fzf-tab-orig-$_ftb_orig_widget
		fi
	fi
	zstyle -t ':completion:*' list-grouped false
	typeset -g _ftb_orig_list_grouped=$? 
	zstyle ':completion:*' list-grouped false
	bindkey -M emacs '^I' fzf-tab-complete
	bindkey -M viins '^I' fzf-tab-complete
	bindkey -M emacs '^X.' fzf-tab-debug
	bindkey -M viins '^X.' fzf-tab-debug
	autoload +X -Uz _main_complete _approximate
	functions[compadd]=$functions[-ftb-compadd] 
	functions[_ftb__main_complete]=$functions[_main_complete] 
	_main_complete () {
		-ftb-complete "$@"
	}
	functions[_ftb__approximate]=$functions[_approximate] 
	_approximate () {
		(( ! IN_FZF_TAB )) || unfunction compadd
		_ftb__approximate
		(( ! IN_FZF_TAB )) || functions[compadd]=$functions[-ftb-compadd] 
	}
}
f () {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd 
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")"  && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]
	then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
fast-theme () {
	# undefined
	builtin autoload -XUz
}
fcd () {
	cd "$(find . -type d -not -path '*/.*' | fzf)" && l
}
ftb-switch-group () {
	# undefined
	builtin autoload -XUz
}
ftb-tmux-popup () {
	# undefined
	builtin autoload -XUz
}
fv () {
	nvim "$(find . -type f -not -path '*/.*' | fzf)"
}
fzf-tab-complete () {
	local -i _ftb_continue=1 _ftb_continue_last=0 _ftb_accept=0 ret=0 
	echoti civis > /dev/tty 2> /dev/null
	while (( _ftb_continue ))
	do
		local _ftb_choices=() _ftb_compcap=() _ftb_finish=0 
		_ftb_continue=0 
		local IN_FZF_TAB=1 
		{
			zle .fzf-tab-orig-$_ftb_orig_widget || ret=$? 
			if (( ! ret && ! _ftb_finish ))
			then
				zle _fzf-tab-apply || ret=$? 
			fi
		} always {
			IN_FZF_TAB=0 
		}
		if (( _ftb_continue ))
		then
			zle .split-undo
			zle .reset-prompt
			zle -R
			zle fzf-tab-dummy
		fi
	done
	echoti cnorm > /dev/tty 2> /dev/null
	zle .redisplay
	(( _ftb_accept )) && zle .accept-line
	return $ret
}
fzf-tab-debug () {
	(( $+_ftb_debug_cnt )) || typeset -gi _ftb_debug_cnt
	local tmp=${TMPPREFIX:-/tmp/zsh}-$$-fzf-tab-$(( ++_ftb_debug_cnt )).log 
	local -i debug_fd=-1 IN_FZF_TAB=1 
	{
		exec {debug_fd}>&2 2>| $tmp
		local -a debug_indent
		debug_indent=('%'{3..20}'(e. .)') 
		local PROMPT4 PS4="${(j::)debug_indent}+%N:%i> " 
		functions -t -- -ftb-complete _fzf-tab-apply fzf-tab-complete
		{
			echo $ZSH_NAME $ZSH_VERSION
			echo fzf-tab: $(-ftb-version)
			typeset -p FZF_DEFAULT_OPTS
			echo $commands[fzf] $(fzf --version)
		} >&2
		zle fzf-tab-complete
		if (( debug_fd != -1 ))
		then
			zle -M "fzf-tab-debug: Trace output left in $tmp"
		fi
	} always {
		functions +t -- -ftb-complete _fzf-tab-apply fzf-tab-complete
		(( debug_fd != -1 )) && exec 2>&$debug_fd {debug_fd}>&-
	}
}
fzf-tab-dummy () {
	
}
fzf-tab-lscolors::from-mode () {
	emulate -L zsh
	setopt cbases octalzeroes extendedglob
	[[ -z $2 ]] && return 1
	local -i reg=0 
	local -a codes
	local -i st_mode=$(($2)) 
	case $(( st_mode & 0170000 )) in
		($(( 0140000 ))) codes=($modecolors[so])  ;;
		($(( 0120000 ))) if ! (($+3))
			then
				REPLY=$modecolors[or] 
			elif [[ $modecolors[ln] = target ]]
			then
				"$0" "$1" "${@:3}"
			else
				REPLY=$modecolors[ln] 
			fi
			return ;;
		($(( 0100000 ))) codes=() 
			reg=1  ;;
		($(( 0060000 ))) codes=($modecolors[bd])  ;;
		($(( 0040000 ))) codes=($modecolors[di])  ;;
		($(( 0020000 ))) codes=($modecolors[cd])  ;;
		($(( 0010000 ))) codes=($modecolors[pi])  ;;
	esac
	(( st_mode & 04000 )) && codes+=($modecolors[su]) 
	(( st_mode & 02000 )) && codes+=($modecolors[sg]) 
	(( ! reg )) && case $(( st_mode & 01002 )) in
		($(( 01000 ))) codes+=($modecolors[st])  ;;
		($(( 00002 ))) codes+=($modecolors[ow])  ;;
		($(( 01002 ))) codes+=($modecolors[tw])  ;;
	esac
	if (( ! $#codes ))
	then
		(( st_mode &  0111 )) && codes+=($modecolors[ex]) 
	fi
	[[ -n ${REPLY::=${(j:;:)codes}} ]]
}
fzf-tab-lscolors::from-name () {
	emulate -L zsh
	setopt extendedglob
	[[ -n ${REPLY::=$namecolors[(k)$1]} ]]
}
fzf-tab-lscolors::init () {
	emulate -L zsh
	local LS_COLORS=${1:-${LS_COLORS:-$LSCOLORS}} 
	typeset -gA namecolors=(${(@s:=:)${(@s.:.)LS_COLORS}:#[[:alpha:]][[:alpha:]]=*}) 
	typeset -gA modecolors=(${(@Ms:=:)${(@s.:.)LS_COLORS}:#[[:alpha:]][[:alpha:]]=*}) 
}
fzf-tab-lscolors::match-by () {
	emulate -L zsh
	setopt extendedglob cbases octalzeroes
	local arg REPLY name=$1 pfx=${0%::match-by} 
	shift
	if ! [[ -v namecolors && -v modecolors ]]
	then
		local -A namecolors modecolors
		${pfx}::init
	fi
	if [[ ${1:l} = (g|global) ]]
	then
		shift
	else
		local -a stat lstat
		declare -ga reply=() 
	fi
	zmodload -F zsh/stat b:zstat
	for arg
	do
		case ${arg[1]:l} in
			(n | name) ${pfx}::from-name $name
				reply+=("$REPLY")  ;;
			(l | lstat) (($#lstat)) || zstat -A lstat -L $name || return 1
				if ((lstat[3] & 0170000 ))
				then
					(($#stat)) || zstat -A stat $name 2> /dev/null
				fi
				${pfx}::from-mode "$name" "$lstat[3]" $stat[3]
				if [[ -n $REPLY || ${2[1]} = L ]]
				then
					reply+=("$REPLY") 
				else
					"$0" "$name" g n
				fi ;;
			(s | stat) (($#stat)) || zstat -A stat $name || return 1
				${pfx}::from-mode $name $stat[3]
				reply+=("$REPLY") 
				if [[ -n $REPLY || ${arg[1]} = S ]]
				then
					reply+=("$REPLY") 
				else
					"$0" "$name" g n
				fi ;;
			(f | follow) (($#lstat)) || zstat -A lstat -L $name || return 1
				reply+=("$lstat[14]")  ;;
			(a | all) "$0" "$name" g ${${${arg[1]%a}:+L}:-l}
				reply+=($lstat[14]) 
				if [[ -n $lstat[14] ]]
				then
					if [[ -e $name ]]
					then
						"$0" "$name" g ${${${arg[1]%a}:+S}:-s}
					else
						reply+=($reply[-2]) 
					fi
				fi ;;
			(*) return 2 ;;
		esac
	done
}
getent () {
	if [[ $1 = hosts ]]
	then
		sed 's/#.*//' /etc/$1 | grep -w $2
	elif [[ $2 = <-> ]]
	then
		grep ":$2:[^:]*$" /etc/$1
	else
		grep "^$2:" /etc/$1
	fi
}
is-at-least () {
	emulate -L zsh
	local IFS=".-" min_cnt=0 ver_cnt=0 part min_ver version order 
	min_ver=(${=1}) 
	version=(${=2:-$ZSH_VERSION} 0) 
	while (( $min_cnt <= ${#min_ver} ))
	do
		while [[ "$part" != <-> ]]
		do
			(( ++ver_cnt > ${#version} )) && return 0
			if [[ ${version[ver_cnt]} = *[0-9][^0-9]* ]]
			then
				order=(${version[ver_cnt]} ${min_ver[ver_cnt]}) 
				if [[ ${version[ver_cnt]} = <->* ]]
				then
					[[ $order != ${${(On)order}} ]] && return 1
				else
					[[ $order != ${${(O)order}} ]] && return 1
				fi
				[[ $order[1] != $order[2] ]] && return 0
			fi
			part=${version[ver_cnt]##*[^0-9]} 
		done
		while true
		do
			(( ++min_cnt > ${#min_ver} )) && return 0
			[[ ${min_ver[min_cnt]} = <-> ]] && break
		done
		(( part > min_ver[min_cnt] )) && return 0
		(( part < min_ver[min_cnt] )) && return 1
		part='' 
	done
}
prompt_starship_precmd () {
	STARSHIP_CMD_STATUS=$? STARSHIP_PIPE_STATUS=(${pipestatus[@]}) 
	if (( ${+STARSHIP_START_TIME} ))
	then
		__starship_get_time && (( STARSHIP_DURATION = STARSHIP_CAPTURED_TIME - STARSHIP_START_TIME ))
		unset STARSHIP_START_TIME
	else
		unset STARSHIP_DURATION STARSHIP_CMD_STATUS STARSHIP_PIPE_STATUS
	fi
	STARSHIP_JOBS_COUNT=${#jobstates} 
}
prompt_starship_preexec () {
	__starship_get_time && STARSHIP_START_TIME=$STARSHIP_CAPTURED_TIME 
}
sesh-sessions () {
	{
		exec < /dev/tty
		exec <&1
		local session
		session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ') 
		zle reset-prompt > /dev/null 2>&1 || true
		[[ -z "$session" ]] && return
		sesh connect $session
	}
}
starship_zle-keymap-select () {
	zle reset-prompt
}
toggle-fzf-tab () {
	emulate -L zsh -o extended_glob
	if (( $+_ftb_orig_widget ))
	then
		disable-fzf-tab
	else
		enable-fzf-tab
	fi
}
vv () {
	local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0) 
	[[ -z $config ]] && echo "No config selected" && return
	NVIM_APPNAME=$(basename $config) nvim $@
}
z () {
	__zoxide_z "$@"
}
zi () {
	__zoxide_zi "$@"
}
.fast-make-targets () {
	# undefined
	builtin autoload -XUz
}
.fast-read-ini-file () {
	# undefined
	builtin autoload -XUz
}
.fast-run-command () {
	# undefined
	builtin autoload -XUz
}
.fast-run-git-command () {
	# undefined
	builtin autoload -XUz
}
.fast-zts-read-all () {
	# undefined
	builtin autoload -XUz
}
/fshdbg () {
	print -r -- "$@" >>| /tmp/reply
}
add-zsh-hook () {
	emulate -L zsh
	local -a hooktypes
	hooktypes=(chpwd precmd preexec periodic zshaddhistory zshexit zsh_directory_name) 
	local usage="Usage: add-zsh-hook hook function\nValid hooks are:\n  $hooktypes" 
	local opt
	local -a autoopts
	integer del list help
	while getopts "dDhLUzk" opt
	do
		case $opt in
			(d) del=1  ;;
			(D) del=2  ;;
			(h) help=1  ;;
			(L) list=1  ;;
			([Uzk]) autoopts+=(-$opt)  ;;
			(*) return 1 ;;
		esac
	done
	shift $(( OPTIND - 1 ))
	if (( list ))
	then
		typeset -mp "(${1:-${(@j:|:)hooktypes}})_functions"
		return $?
	elif (( help || $# != 2 || ${hooktypes[(I)$1]} == 0 ))
	then
		print -u$(( 2 - help )) $usage
		return $(( 1 - help ))
	fi
	local hook="${1}_functions" 
	local fn="$2" 
	if (( del ))
	then
		if (( ${(P)+hook} ))
		then
			if (( del == 2 ))
			then
				set -A $hook ${(P)hook:#${~fn}}
			else
				set -A $hook ${(P)hook:#$fn}
			fi
			if (( ! ${(P)#hook} ))
			then
				unset $hook
			fi
		fi
	else
		if (( ${(P)+hook} ))
		then
			if (( ${${(P)hook}[(I)$fn]} == 0 ))
			then
				typeset -ga $hook
				set -A $hook ${(P)hook} $fn
			fi
		else
			typeset -ga $hook
			set -A $hook $fn
		fi
		autoload $autoopts -- $fn
	fi
}
brew () {
	command brew "$@"
	if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]] || [[ $* =~ "list" ]] || [[ $* =~ "install" ]] || [[ $* =~ "uninstall" ]] || [[ $* =~ "bundle" ]] || [[ $* =~ "doctor" ]] || [[ $* =~ "info" ]] || [[ $* =~ "cleanup" ]]
	then
		sketchybar --trigger brew_update
	fi
}
build-fzf-tab-module () {
	{
		pushd -q $FZF_TAB_HOME/modules
		if -ftb-build-module $@
		then
			print -P "%F{green}%BThe module has been built successfully. Please restart zsh to apply it.%f%b"
		else
			print -P -u2 "%F{red}%BThe module building has failed. See the output above for details.%f%b"
			return 1
		fi
	} always {
		popd -q
	}
}
compadd () {
	local -A apre hpre dscrs _oad _mesg
	local -a isfile _opts __ expl
	zparseopts -a _opts P:=apre p:=hpre d:=dscrs X+:=expl O:=_oad A:=_oad D:=_oad f=isfile i: S: s: I: x:=_mesg r: R: W: F: M+: E: q e Q n U C J:=__ V:=__ a=__ l=__ k=__ o::=__ 1=__ 2=__
	_ftb_curcontext=${curcontext#:} 
	if (( $#_oad != 0 || ! IN_FZF_TAB )) || {
			-ftb-zstyle -m disabled-on "any"
		} || {
			-ftb-zstyle -m disabled-on "files" && [[ -n $isfile ]]
		}
	then
		builtin compadd "$@"
		return
	fi
	local -a __hits __dscr
	if (( $#dscrs == 1 ))
	then
		__dscr=("${(@P)${(v)dscrs}}") 
	fi
	builtin compadd -A __hits -D __dscr "$@"
	local ret=$? 
	if (( $#__hits == 0 ))
	then
		if is-at-least 5.9 && (( $#_mesg != 0 ))
		then
			builtin compadd -x $_mesg
		fi
		return $ret
	fi
	expl=$expl[2] 
	[[ -n $expl ]] && _ftb_groups+=$expl 
	local -a keys=(apre hpre PREFIX SUFFIX IPREFIX ISUFFIX) 
	local key expanded __tmp_value=$'<\0>' 
	for key in $keys
	do
		expanded=${(P)key} 
		if [[ -n $expanded ]]
		then
			__tmp_value+=$'\0'$key$'\0'$expanded 
		fi
	done
	if [[ -n $expl ]]
	then
		__tmp_value+=$'\0group\0'$_ftb_groups[(ie)$expl] 
	fi
	if [[ -n $isfile ]]
	then
		__tmp_value+=$'\0realdir\0'${${(Qe)~${:-$IPREFIX$hpre}}} 
	fi
	_opts+=("${(@kv)apre}" "${(@kv)hpre}" $isfile) 
	__tmp_value+=$'\0args\0'${(pj:\1:)_opts} 
	if (( $+builtins[fzf-tab-compcap-generate] ))
	then
		fzf-tab-compcap-generate __hits __dscr __tmp_value
	else
		local dscr word i
		for i in {1..$#__hits}
		do
			word=$__hits[i] dscr=$__dscr[i] 
			if [[ -n $dscr ]]
			then
				dscr=${dscr//$'\n'} 
			elif [[ -n $word ]]
			then
				dscr=$word 
			fi
			_ftb_compcap+=$dscr$'\2'$__tmp_value$'\0word\0'$word 
		done
	fi
	builtin compadd "$@"
}
compaudit () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
compdef () {
	local opt autol type func delete eval new i ret=0 cmd svc 
	local -a match mbegin mend
	emulate -L zsh
	setopt extendedglob
	if (( ! $# ))
	then
		print -u2 "$0: I need arguments"
		return 1
	fi
	while getopts "anpPkKde" opt
	do
		case "$opt" in
			(a) autol=yes  ;;
			(n) new=yes  ;;
			([pPkK]) if [[ -n "$type" ]]
				then
					print -u2 "$0: type already set to $type"
					return 1
				fi
				if [[ "$opt" = p ]]
				then
					type=pattern 
				elif [[ "$opt" = P ]]
				then
					type=postpattern 
				elif [[ "$opt" = K ]]
				then
					type=widgetkey 
				else
					type=key 
				fi ;;
			(d) delete=yes  ;;
			(e) eval=yes  ;;
		esac
	done
	shift OPTIND-1
	if (( ! $# ))
	then
		print -u2 "$0: I need arguments"
		return 1
	fi
	if [[ -z "$delete" ]]
	then
		if [[ -z "$eval" ]] && [[ "$1" = *\=* ]]
		then
			while (( $# ))
			do
				if [[ "$1" = *\=* ]]
				then
					cmd="${1%%\=*}" 
					svc="${1#*\=}" 
					func="$_comps[${_services[(r)$svc]:-$svc}]" 
					[[ -n ${_services[$svc]} ]] && svc=${_services[$svc]} 
					[[ -z "$func" ]] && func="${${_patcomps[(K)$svc][1]}:-${_postpatcomps[(K)$svc][1]}}" 
					if [[ -n "$func" ]]
					then
						_comps[$cmd]="$func" 
						_services[$cmd]="$svc" 
					else
						print -u2 "$0: unknown command or service: $svc"
						ret=1 
					fi
				else
					print -u2 "$0: invalid argument: $1"
					ret=1 
				fi
				shift
			done
			return ret
		fi
		func="$1" 
		[[ -n "$autol" ]] && autoload -rUz "$func"
		shift
		case "$type" in
			(widgetkey) while [[ -n $1 ]]
				do
					if [[ $# -lt 3 ]]
					then
						print -u2 "$0: compdef -K requires <widget> <comp-widget> <key>"
						return 1
					fi
					[[ $1 = _* ]] || 1="_$1" 
					[[ $2 = .* ]] || 2=".$2" 
					[[ $2 = .menu-select ]] && zmodload -i zsh/complist
					zle -C "$1" "$2" "$func"
					if [[ -n $new ]]
					then
						bindkey "$3" | IFS=$' \t' read -A opt
						[[ $opt[-1] = undefined-key ]] && bindkey "$3" "$1"
					else
						bindkey "$3" "$1"
					fi
					shift 3
				done ;;
			(key) if [[ $# -lt 2 ]]
				then
					print -u2 "$0: missing keys"
					return 1
				fi
				if [[ $1 = .* ]]
				then
					[[ $1 = .menu-select ]] && zmodload -i zsh/complist
					zle -C "$func" "$1" "$func"
				else
					[[ $1 = menu-select ]] && zmodload -i zsh/complist
					zle -C "$func" ".$1" "$func"
				fi
				shift
				for i
				do
					if [[ -n $new ]]
					then
						bindkey "$i" | IFS=$' \t' read -A opt
						[[ $opt[-1] = undefined-key ]] || continue
					fi
					bindkey "$i" "$func"
				done ;;
			(*) while (( $# ))
				do
					if [[ "$1" = -N ]]
					then
						type=normal 
					elif [[ "$1" = -p ]]
					then
						type=pattern 
					elif [[ "$1" = -P ]]
					then
						type=postpattern 
					else
						case "$type" in
							(pattern) if [[ $1 = (#b)(*)=(*) ]]
								then
									_patcomps[$match[1]]="=$match[2]=$func" 
								else
									_patcomps[$1]="$func" 
								fi ;;
							(postpattern) if [[ $1 = (#b)(*)=(*) ]]
								then
									_postpatcomps[$match[1]]="=$match[2]=$func" 
								else
									_postpatcomps[$1]="$func" 
								fi ;;
							(*) if [[ "$1" = *\=* ]]
								then
									cmd="${1%%\=*}" 
									svc=yes 
								else
									cmd="$1" 
									svc= 
								fi
								if [[ -z "$new" || -z "${_comps[$1]}" ]]
								then
									_comps[$cmd]="$func" 
									[[ -n "$svc" ]] && _services[$cmd]="${1#*\=}" 
								fi ;;
						esac
					fi
					shift
				done ;;
		esac
	else
		case "$type" in
			(pattern) unset "_patcomps[$^@]" ;;
			(postpattern) unset "_postpatcomps[$^@]" ;;
			(key) print -u2 "$0: cannot restore key bindings"
				return 1 ;;
			(*) unset "_comps[$^@]" ;;
		esac
	fi
}
compdump () {
	# undefined
	builtin autoload -XUz
}
compinit () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
compinstall () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/5.9/functions
}
disable-fzf-tab () {
	emulate -L zsh -o extended_glob
	(( $+_ftb_orig_widget )) || return 0
	bindkey '^I' $_ftb_orig_widget
	case $_ftb_orig_list_grouped in
		(0) zstyle ':completion:*' list-grouped false ;;
		(1) zstyle ':completion:*' list-grouped true ;;
		(2) zstyle -d ':completion:*' list-grouped ;;
	esac
	unset _ftb_orig_widget _ftb_orig_list_groupded
	unfunction compadd 2> /dev/null
	functions[_main_complete]=$functions[_ftb__main_complete] 
	functions[_approximate]=$functions[_ftb__approximate] 
}
enable-fzf-tab () {
	emulate -L zsh -o extended_glob
	(( ! $+_ftb_orig_widget )) || disable-fzf-tab
	typeset -g _ftb_orig_widget="${${$(builtin bindkey '^I')##* }:-expand-or-complete}" 
	if (( ! $+widgets[.fzf-tab-orig-$_ftb_orig_widget] ))
	then
		local compinit_widgets=(complete-word delete-char-or-list expand-or-complete expand-or-complete-prefix list-choices menu-complete menu-expand-or-complete reverse-menu-complete) 
		if [[ $widgets[$_ftb_orig_widget] == builtin && $compinit_widgets[(Ie)$_ftb_orig_widget] != 0 ]]
		then
			zle -C .fzf-tab-orig-$_ftb_orig_widget .$_ftb_orig_widget _main_complete
		else
			zle -A $_ftb_orig_widget .fzf-tab-orig-$_ftb_orig_widget
		fi
	fi
	zstyle -t ':completion:*' list-grouped false
	typeset -g _ftb_orig_list_grouped=$? 
	zstyle ':completion:*' list-grouped false
	bindkey -M emacs '^I' fzf-tab-complete
	bindkey -M viins '^I' fzf-tab-complete
	bindkey -M emacs '^X.' fzf-tab-debug
	bindkey -M viins '^X.' fzf-tab-debug
	autoload +X -Uz _main_complete _approximate
	functions[compadd]=$functions[-ftb-compadd] 
	functions[_ftb__main_complete]=$functions[_main_complete] 
	_main_complete () {
		-ftb-complete "$@"
	}
	functions[_ftb__approximate]=$functions[_approximate] 
	_approximate () {
		(( ! IN_FZF_TAB )) || unfunction compadd
		_ftb__approximate
		(( ! IN_FZF_TAB )) || functions[compadd]=$functions[-ftb-compadd] 
	}
}
f () {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd 
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")"  && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]
	then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
fast-theme () {
	# undefined
	builtin autoload -XUz
}
fcd () {
	cd "$(find . -type d -not -path '*/.*' | fzf)" && l
}
ftb-switch-group () {
	# undefined
	builtin autoload -XUz
}
ftb-tmux-popup () {
	# undefined
	builtin autoload -XUz
}
fv () {
	nvim "$(find . -type f -not -path '*/.*' | fzf)"
}
fzf-tab-complete () {
	local -i _ftb_continue=1 _ftb_continue_last=0 _ftb_accept=0 ret=0 
	echoti civis > /dev/tty 2> /dev/null
	while (( _ftb_continue ))
	do
		local _ftb_choices=() _ftb_compcap=() _ftb_finish=0 
		_ftb_continue=0 
		local IN_FZF_TAB=1 
		{
			zle .fzf-tab-orig-$_ftb_orig_widget || ret=$? 
			if (( ! ret && ! _ftb_finish ))
			then
				zle _fzf-tab-apply || ret=$? 
			fi
		} always {
			IN_FZF_TAB=0 
		}
		if (( _ftb_continue ))
		then
			zle .split-undo
			zle .reset-prompt
			zle -R
			zle fzf-tab-dummy
		fi
	done
	echoti cnorm > /dev/tty 2> /dev/null
	zle .redisplay
	(( _ftb_accept )) && zle .accept-line
	return $ret
}
fzf-tab-debug () {
	(( $+_ftb_debug_cnt )) || typeset -gi _ftb_debug_cnt
	local tmp=${TMPPREFIX:-/tmp/zsh}-$$-fzf-tab-$(( ++_ftb_debug_cnt )).log 
	local -i debug_fd=-1 IN_FZF_TAB=1 
	{
		exec {debug_fd}>&2 2>| $tmp
		local -a debug_indent
		debug_indent=('%'{3..20}'(e. .)') 
		local PROMPT4 PS4="${(j::)debug_indent}+%N:%i> " 
		functions -t -- -ftb-complete _fzf-tab-apply fzf-tab-complete
		{
			echo $ZSH_NAME $ZSH_VERSION
			echo fzf-tab: $(-ftb-version)
			typeset -p FZF_DEFAULT_OPTS
			echo $commands[fzf] $(fzf --version)
		} >&2
		zle fzf-tab-complete
		if (( debug_fd != -1 ))
		then
			zle -M "fzf-tab-debug: Trace output left in $tmp"
		fi
	} always {
		functions +t -- -ftb-complete _fzf-tab-apply fzf-tab-complete
		(( debug_fd != -1 )) && exec 2>&$debug_fd {debug_fd}>&-
	}
}
fzf-tab-dummy () {
	
}
fzf-tab-lscolors::from-mode () {
	emulate -L zsh
	setopt cbases octalzeroes extendedglob
	[[ -z $2 ]] && return 1
	local -i reg=0 
	local -a codes
	local -i st_mode=$(($2)) 
	case $(( st_mode & 0170000 )) in
		($(( 0140000 ))) codes=($modecolors[so])  ;;
		($(( 0120000 ))) if ! (($+3))
			then
				REPLY=$modecolors[or] 
			elif [[ $modecolors[ln] = target ]]
			then
				"$0" "$1" "${@:3}"
			else
				REPLY=$modecolors[ln] 
			fi
			return ;;
		($(( 0100000 ))) codes=() 
			reg=1  ;;
		($(( 0060000 ))) codes=($modecolors[bd])  ;;
		($(( 0040000 ))) codes=($modecolors[di])  ;;
		($(( 0020000 ))) codes=($modecolors[cd])  ;;
		($(( 0010000 ))) codes=($modecolors[pi])  ;;
	esac
	(( st_mode & 04000 )) && codes+=($modecolors[su]) 
	(( st_mode & 02000 )) && codes+=($modecolors[sg]) 
	(( ! reg )) && case $(( st_mode & 01002 )) in
		($(( 01000 ))) codes+=($modecolors[st])  ;;
		($(( 00002 ))) codes+=($modecolors[ow])  ;;
		($(( 01002 ))) codes+=($modecolors[tw])  ;;
	esac
	if (( ! $#codes ))
	then
		(( st_mode &  0111 )) && codes+=($modecolors[ex]) 
	fi
	[[ -n ${REPLY::=${(j:;:)codes}} ]]
}
fzf-tab-lscolors::from-name () {
	emulate -L zsh
	setopt extendedglob
	[[ -n ${REPLY::=$namecolors[(k)$1]} ]]
}
fzf-tab-lscolors::init () {
	emulate -L zsh
	local LS_COLORS=${1:-${LS_COLORS:-$LSCOLORS}} 
	typeset -gA namecolors=(${(@s:=:)${(@s.:.)LS_COLORS}:#[[:alpha:]][[:alpha:]]=*}) 
	typeset -gA modecolors=(${(@Ms:=:)${(@s.:.)LS_COLORS}:#[[:alpha:]][[:alpha:]]=*}) 
}
fzf-tab-lscolors::match-by () {
	emulate -L zsh
	setopt extendedglob cbases octalzeroes
	local arg REPLY name=$1 pfx=${0%::match-by} 
	shift
	if ! [[ -v namecolors && -v modecolors ]]
	then
		local -A namecolors modecolors
		${pfx}::init
	fi
	if [[ ${1:l} = (g|global) ]]
	then
		shift
	else
		local -a stat lstat
		declare -ga reply=() 
	fi
	zmodload -F zsh/stat b:zstat
	for arg
	do
		case ${arg[1]:l} in
			(n | name) ${pfx}::from-name $name
				reply+=("$REPLY")  ;;
			(l | lstat) (($#lstat)) || zstat -A lstat -L $name || return 1
				if ((lstat[3] & 0170000 ))
				then
					(($#stat)) || zstat -A stat $name 2> /dev/null
				fi
				${pfx}::from-mode "$name" "$lstat[3]" $stat[3]
				if [[ -n $REPLY || ${2[1]} = L ]]
				then
					reply+=("$REPLY") 
				else
					"$0" "$name" g n
				fi ;;
			(s | stat) (($#stat)) || zstat -A stat $name || return 1
				${pfx}::from-mode $name $stat[3]
				reply+=("$REPLY") 
				if [[ -n $REPLY || ${arg[1]} = S ]]
				then
					reply+=("$REPLY") 
				else
					"$0" "$name" g n
				fi ;;
			(f | follow) (($#lstat)) || zstat -A lstat -L $name || return 1
				reply+=("$lstat[14]")  ;;
			(a | all) "$0" "$name" g ${${${arg[1]%a}:+L}:-l}
				reply+=($lstat[14]) 
				if [[ -n $lstat[14] ]]
				then
					if [[ -e $name ]]
					then
						"$0" "$name" g ${${${arg[1]%a}:+S}:-s}
					else
						reply+=($reply[-2]) 
					fi
				fi ;;
			(*) return 2 ;;
		esac
	done
}
getent () {
	if [[ $1 = hosts ]]
	then
		sed 's/#.*//' /etc/$1 | grep -w $2
	elif [[ $2 = <-> ]]
	then
		grep ":$2:[^:]*$" /etc/$1
	else
		grep "^$2:" /etc/$1
	fi
}
is-at-least () {
	emulate -L zsh
	local IFS=".-" min_cnt=0 ver_cnt=0 part min_ver version order 
	min_ver=(${=1}) 
	version=(${=2:-$ZSH_VERSION} 0) 
	while (( $min_cnt <= ${#min_ver} ))
	do
		while [[ "$part" != <-> ]]
		do
			(( ++ver_cnt > ${#version} )) && return 0
			if [[ ${version[ver_cnt]} = *[0-9][^0-9]* ]]
			then
				order=(${version[ver_cnt]} ${min_ver[ver_cnt]}) 
				if [[ ${version[ver_cnt]} = <->* ]]
				then
					[[ $order != ${${(On)order}} ]] && return 1
				else
					[[ $order != ${${(O)order}} ]] && return 1
				fi
				[[ $order[1] != $order[2] ]] && return 0
			fi
			part=${version[ver_cnt]##*[^0-9]} 
		done
		while true
		do
			(( ++min_cnt > ${#min_ver} )) && return 0
			[[ ${min_ver[min_cnt]} = <-> ]] && break
		done
		(( part > min_ver[min_cnt] )) && return 0
		(( part < min_ver[min_cnt] )) && return 1
		part='' 
	done
}
prompt_starship_precmd () {
	STARSHIP_CMD_STATUS=$? STARSHIP_PIPE_STATUS=(${pipestatus[@]}) 
	if (( ${+STARSHIP_START_TIME} ))
	then
		__starship_get_time && (( STARSHIP_DURATION = STARSHIP_CAPTURED_TIME - STARSHIP_START_TIME ))
		unset STARSHIP_START_TIME
	else
		unset STARSHIP_DURATION STARSHIP_CMD_STATUS STARSHIP_PIPE_STATUS
	fi
	STARSHIP_JOBS_COUNT=${#jobstates} 
}
prompt_starship_preexec () {
	__starship_get_time && STARSHIP_START_TIME=$STARSHIP_CAPTURED_TIME 
}
sesh-sessions () {
	{
		exec < /dev/tty
		exec <&1
		local session
		session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ') 
		zle reset-prompt > /dev/null 2>&1 || true
		[[ -z "$session" ]] && return
		sesh connect $session
	}
}
starship_zle-keymap-select () {
	zle reset-prompt
}
toggle-fzf-tab () {
	emulate -L zsh -o extended_glob
	if (( $+_ftb_orig_widget ))
	then
		disable-fzf-tab
	else
		enable-fzf-tab
	fi
}
vv () {
	local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0) 
	[[ -z $config ]] && echo "No config selected" && return
	NVIM_APPNAME=$(basename $config) nvim $@
}
z () {
	__zoxide_z "$@"
}
zi () {
	__zoxide_zi "$@"
}
# Shell Options
setopt nohashdirs
setopt login
setopt nopromptsp
setopt promptsubst
# Aliases
alias -- ..='cd ..'
alias -- ...='cd ../..'
alias -- ....='cd ../../..'
alias -- .....='cd ../../../..'
alias -- ......='cd ../../../../..'
alias -- C='cd ~/Code/'
alias -- cl=clear
alias -- claude=/Users/cyperx/.claude/local/claude
alias -- cld=/Users/cyperx/.claude/local/claude
alias -- conf='cd /Users/cyperx/dotfiles && nvim'
alias -- dco='docker compose'
alias -- dkill='killall "Docker Desktop" && sleep 1 && dock'
alias -- dl='docker ps -l -q'
alias -- dock='open -a docker && while ! docker info > /dev/null 2>&1; do sleep 1 ; done'
alias -- dpa='docker ps -a'
alias -- dps='docker ps'
alias -- dx='docker exec -it'
alias -- fsh-alias=fast-theme
alias -- ga='git add -p'
alias -- gadd='git add'
alias -- gb='git branch'
alias -- gba='git branch -a'
alias -- gc='git commit -m'
alias -- gca='git commit -a -m'
alias -- gco='git checkout'
alias -- gcoall='git checkout -- .'
alias -- gdiff='git diff'
alias -- ghl='gh repo list'
alias -- glog='git log --graph --topo-order --pretty='\''%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N'\'' --abbrev-commit'
alias -- gp='git push origin HEAD'
alias -- gpu='git pull origin'
alias -- gr='git remote'
alias -- gre='git reset'
alias -- gs='git status'
alias -- http=xh
alias -- iva='find . -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.webp" -o -iname "*.svg" \) -exec kitty +kitten icat {} \;'
alias -- k=kubectl
alias -- ka='kubectl apply -f'
alias -- kc=kubectx
alias -- kcns='kubectl config set-context --current --namespace'
alias -- kd='kubectl describe'
alias -- kdel='kubectl delete'
alias -- ke='kubectl exec -it'
alias -- kg='kubectl get'
alias -- kgd='kubectl get deployments'
alias -- kgpo='kubectl get pod'
alias -- kl='kubectl logs -f'
alias -- kns=kubens
alias -- l='eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions'
alias -- ll='eza --color=always --long --git --icons=always'
alias -- ls='eza -l --icons --git -a'
alias -- lt='eza --tree --level=2 --long --icons --git'
alias -- ltree='eza --tree --level=2  --icons --git'
alias -- n='NVIM_APPNAME="nvim" nvim'
alias -- nm='nmap -sC -sV -oN nmap'
alias -- no='cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/notes && nvim INDEX.md'
alias -- podname=''
alias -- run-help=man
alias -- ta='tmux attach -d'
alias -- vim=nvim
alias -- which-command=whence
# Check for rg availability
if ! command -v rg >/dev/null 2>&1; then
  alias rg='/opt/homebrew/Cellar/ripgrep/14.1.1/bin/rg'
fi
export PATH=/Users/cyperx/.local/bin\:/Users/cyperx/.local/share/nvim/mason/bin\:/usr/local/bin\:/usr/local/sbin\:/usr/local/sbin\:/opt/homebrew/opt/icu4c\@77/bin\:/Users/cyperx/.npm-global/bin\:/opt/homebrew/bin\:/opt/homebrew/sbin\:/usr/local/bin\:/System/Cryptexes/App/usr/bin\:/usr/bin\:/bin\:/usr/sbin\:/sbin\:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin\:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin\:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin\:/Library/TeX/texbin\:/Users/cyperx/.local/bin\:/usr/local/sbin\:/opt/homebrew/opt/icu4c\@77/bin\:/Users/cyperx/.npm-global/bin\:/Applications/Ghostty.app/Contents/MacOS\:/Users/cyperx/.claude/local\:/Users/cyperx/.claude/local
