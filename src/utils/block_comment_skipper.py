import re

class BlockCommentSkipper:    
    active_block_comment = False

    def skip_block_comments(self, line: str):
        in_line_block_comment = re.search(r"\/\*.*\*\/", line)
        starting_block_comment = re.search(r"\/\*.*", line)
        starting_block_comment2 = re.search(r"\/\*", line)
        ending_block_comment = re.search(r".*\*\/", line)

        if self.active_block_comment:
            if ending_block_comment:
                line = line.replace(ending_block_comment.string, "")
                self.active_block_comment = False

                return line

            line = ""

        elif in_line_block_comment:
            line = line.replace(in_line_block_comment.string, "")

        elif starting_block_comment or starting_block_comment2:
            self.active_block_comment = True
            line = line.replace(starting_block_comment.string, "")
        
        return line