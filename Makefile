# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: elerazo- <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/07 13:27:33 by elerazo-          #+#    #+#              #
#    Updated: 2025/04/07 21:54:22 by elerazo-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
NAME		=	fractol
CC			=	cc
CFLAGS		=	-Wall -Wextra -Werror -I Inc/ 
MINIFLAGS	=	-lXext -lX11 -lm -lz 
OBJDIR		=	build
SRCSDIR		=	src
SRCS		=	main.c fractal_initit.c fractol.c math_util.c key_handler.c

MLX_PATH	=	./libs/minilibx
LIBFT_PATH	=	./libs/libft/
PRINTF_PATH =	./libs/printf/
MLX			=	$(MLX_PATH)/libmlx.a $(MLX_PATH)/libmlx_Linux.a
LIBFT		=	$(LIBFT_PATH)/libft.a
PRINTF		=	$(PRINTF_PATH)/libftprintf.a

OBJS		=	$(addprefix $(OBJDIR)/, ${SRCS:.c=.o})

PURPLE		=	\033[0;33m
BLUE		=	\033[0;33m
GREEN		=	\033[0;32m
RED			=	\033[0;31m
RESET		=	\033[m

all: banner $(NAME)

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
	@$(CC) $(CFLAGS) $^ $(MINIFLAGS) -o $@

$(MLX):
	@make -C $(MLX_PATH) > /dev/null 2>&1

$(LIBFT):
	@make -C $(LIBFT_PATH) > /dev/null 2>&1

$(PRINTF):
	@make -C $(PRINTF_PATH) > /dev/null 2>&1

fclean: banner clean
	@printf "%b" "$(BLUE)$(@)ing...$(RESET)\n"
	@rm -rf $(NAME)
	@make fclean -C $(LIBFT_PATH) > /dev/null 2>&1
	@make fclean -C $(PRINTF_PATH) > /dev/null 2>&1

clean: banner
	@printf "%b" "$(BLUE)$(@)ing...$(RESET)\n"
	@rm -rf $(OBJDIR)
	@make clean -C $(LIBFT_PATH) > /dev/null 2>&1
	@make clean -C $(PRINTF_PATH) > /dev/null 2>&1

re:    fclean all

.PHONY: all banner clean fclean re $(MLX) $(LIBFT) $(PRINTF)
