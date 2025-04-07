# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: elerazo- <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/07 13:27:33 by elerazo-          #+#    #+#              #
#    Updated: 2025/04/07 15:38:18 by elerazo-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
NAME		=	fractol
CC			=	cc
CFLAGS		=	-Wall -Wextra -Werror -Iminilibx-linux -I Inc/
MINIFLAGS	=	-Lminilibx-linux -lmlx -lXext -lX11 -lm -lbsd
OBJDIR		=	build
SRCSDIR		=	Src
SRCS		=	main.c fractal_initit.c fractol.c math_util.c key_handler.c

MLX_PATH	=	./minilibx-linux
LIBFT_PATH	=	Inc/libft
PRINTF_PATH =	Inc/printf
MLX			=	$(MLX_PATH)/libmlx.a
LIBFT		=	$(LIBFT_PATH)/libft.a
PRINTF		=	$(PRINTF_PATH)/libftprintf.a

OBJS		=	$(addprefix $(OBJDIR)/, ${SRCS:.c=.o})

PURPLE		=	\033[0;33m
BLUE		=	\033[0;33m
GREEN		=	\033[0;32m
RED			=	\033[0;31m
RESET		=	\033[m

all: lib print minilib banner $(NAME) #mirar

banner:
	@printf "%b" "$(PURPLE)\n"                                                           
	@echo "    .-''-.    .---.       .-''-.  .-------.       ____      ____..--'    ,-----.     "
	@echo "  .'_ _   \   | ,_|     .'_ _   \ |  _ _   \    .'  __ \`.  |        |  .'  .-,  '.   "
	@echo " / ( \` )   ',-./  )    / ( \` )   '| ( ' )  |   /   '  \  \ |   .-'  ' / ,-.|  \ _ \  "
	@echo ". (_ o _)  |\  '_ '\`) . (_ o _)  ||(_ o _) /   |___|  /  | |.-'.'   /;  \  '_ /  | : "
	@echo "|  (_,_)___| > (_)  ) |  (_,_)___|| (_,_).' __    _.-\`   |    /   _/ |  _\`,/ \ _/  | "
	@echo "'  \   .---.(  .  .-' '  \   .---.|  |\ \  |  |.'   _    |  .'._( )_ : (  '\_/ \   ; "
	@echo " \  \`-'    / \`-'\`-'|___\  \`-'    /|  | \ \`'   /|  _( )_  |.'  (_'o._) \ \`\"/  \  ) /  "
	@echo "  \       /   |        \\       / |  |  \    / \ (_ o _) /|    (_,_)|  '. \_/\`\`\".'   "
	@echo "   \`'-..-'    \`--------\` \`'-..-'  ''-'   \`'-'   '.(_,_).' |_________|    '-----'     "
	@echo "                                                                                     "                                                        
	@printf "%b" "\n$(RESET)"


$(OBJS): $(OBJDIR)/%.o : $(SRCSDIR)/%.c Inc/fractol.h | $(OBJDIR)
	@printf "%-42b" "$(BLUE)compiling... $(PURPLE)$(@F)$(RESET)\n"
	@$(CC) $(CFLAGS) $(MINIFLAGS) -c $< -o $@

$(OBJDIR):
	@-mkdir $(OBJDIR)

$(NAME): $(OBJS) $(LIBFT) $(PRINTF) $(MLX) 
	@printf "%-42b" "$(BLUE)linking... $(PURPLE)$(@F)$(RESET)\n"
	@$(CC) $(CFLAGS) $(MINIFLAGS) $^ -o $@

minilib:
	@make -C $(MLX_PATH) --quiet --no-print-directory > /dev/null 2>&1

lib:
	@make -C $(LIBFT_PATH) --quiet --no-print-directory

print:
	@make -C $(PRINTF_PATH) --quiet --no-print-directory

fclean: banner clean
	@printf "%b" "$(BLUE)$(@)ing...$(RESET)\n"
	@rm -rf $(NAME)
	@make fclean -C $(LIBFT_PATH) --quiet --no-print-directory
	@make fclean -C $(PRINTF_PATH) --quiet --no-print-directory

clean: banner
	@printf "%b" "$(BLUE)$(@)ing...$(RESET)\n"
	@rm -rf $(OBJDIR)
	@make clean -C $(MLX_PATH) --quiet --no-print-directory
	@make clean -C $(LIBFT_PATH) --quiet --no-print-directory
	@make clean -C $(PRINTF_PATH) --quiet --no-print-directory

re:    fclean all

.PHONY: all banner clean fclean re lib print minilib
