class Node

    attr_accessor :arr, :mid, :left, :right, :data

    def initialize(data)
        @data = data
        @left = nil
        @right = nil
      end

end

class Tree

    attr_accessor :arr, :root

    def initialize(arr)
        @arr = arr.sort.uniq
        @root = build_tree(@arr)
    end

    def build_tree(array)
        return nil if array.empty?
        return Node.new(array.first) if array.length == 1
        
        mid = array.length / 2
        root_node = Node.new(array[mid])
        root_node.left = build_tree(array.take(mid))
        root_node.right = build_tree(array.drop(mid + 1))
        root_node
    end

    def insert(leaf, root_node=@root)
        if leaf < root_node.data
            return root_node.left = Node.new(leaf) if root_node.left.nil?
            insert(leaf, root_node.left)
        elsif leaf > root_node.data
            return root_node.right = Node.new(leaf) if root_node.right.nil?
            insert(leaf, root_node.right)
        end
    end

    def delete(node, root_node=@root)
        return if root_node.nil?
        new_node = root_node
        if node < new_node.data
            new_node.left = delete(node, new_node.left)
        elsif node > new_node.data        
            new_node.right = delete(node, new_node.right)
        else
            if new_node.left.nil?
                temp = new_node.right
                new_node = nil
                return temp
            elsif new_node.right.nil?
                temp = new_node.left
                new_node = nil
                return temp
            end
            temp = min(new_node.right)
            new_node.data = temp.data
            new_node.right = delete(temp.data, new_node.right)

        end
        new_node
        
    end

    def min(node)
        
      current = node
      current = current.left until current.left.nil?
      current

    end

    def find(node=@root, value)
        return if node.nil?
        return node if node.data == value
        if value < node.data
            find(node.left, value)
        else
            find(node.right, value)
        end
    end

    def level_order(node=@root, queue = [])
        print "#{node.data} "
        queue << node.left unless node.left.nil?
        queue << node.right unless node.right.nil?
        return if queue.empty?
        level_order(queue.shift, queue)
    end

    def preorder(node=@root, array=[])
        return if node.nil?
        print "#{node.data} "
        array << node.left unless node.left.nil?
        array << node.right unless node.right.nil?
        preorder(node.left, array)
        preorder(node.right, array)
    end

    def inorder(node=@root, array=[root])
        return if node.nil?
        inorder(node.left, array)
        array << node.left unless node.left.nil?
        print "#{node.data} "
        inorder(node.right, array)
        array << node.right unless node.right.nil?
    end

    def postorder(node=@root, array=[])
        return if node.nil?
        postorder(node.left, array)
        array << node.left unless node.left.nil?
        postorder(node.right, array)
        array << node.right unless node.right.nil?
        print "#{node.data} "
    end

    def height(node=@root.data)
        node = find(node)
        def node_height(node)  
            return -1 if node.nil?
            leftheight = node_height(node.left)
            rightheight = node_height(node.right)
            def max(a,b)
                a > b ? a : b
            end
            return max(leftheight, rightheight) +1
        end
        node_height(node)
    end

    def depth(node=@root.data)
        node = find(node)
        node_height = height(node.data)
        root_height = height
        node_depth = root_height - node_height
    end

    def balanced?
        
        def difference(node=@root, arr=[])
            return if node.nil?

            node.left.nil? ? lvalue = 0 : lvalue = node.left.data
            node.right.nil? ? rvalue = 0 : rvalue = node.right.data

            left_height = height(lvalue)
            right_height = height(rvalue)

            diff = left_height - right_height
            arr << diff
        
            if diff > 1 or diff < -1
                puts "Tree unbalaced at node #{node.data}"
            end

            difference(node.left, arr)
            difference(node.right, arr)

            return arr
        end

        if difference.any? {|diff| diff > 1 or diff < -1}
            # rebalance
            return false
        else
            puts "Balanced tree"
            return true
        end
        
        
  
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    def rebalance
        arr = []
        inorder.each do |x|
            arr << x.data
        end
        puts
        balanced_tree = Tree.new(arr)
        balanced_tree.pretty_print
        @root = balanced_tree.root

    end



    def child
        if root_node.right.nil? and root_node.left != nil
            p true
        end
    end

end

# t = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345])

# t.insert(6)
# t.insert(11)
# t.insert(25)
# t.delete(67)
# t.insert(25)
# t.insert(2)
# t.insert(100)
# t.insert(101)
# t.delete(67)
# t.delete(4)
# t.delete(3)
# t.delete(9)
# t.delete(7)
# t.delete(5)
# t.insert(24)
# t.delete(25)
# t.delete(24)
# t.delete(6)
# t.delete(23)
# t.delete(67)
# t.delete(6345)
# t.delete(11)
# t.delete(5)
# t.delete(2)
# t.delete(2)
# t.delete(11)
# t.delete(10)
# t.delete(9)
# t.delete(23)
# t.delete(6345)
# t.delete(67)
# t.delete(5)
# t.delete(1)
# t.insert(24)
# t.delete(24)
# t.pretty_print
# t.child
# p t.find(5)
# t.find(23)
# p t.find(3)
# t.find(8)
# p t.find(4)
# t.level_order
# t.preorder
# t.inorder
# t.postorder
# p t.height
# p t.depth(4)
# p t.depth(3)
# p t.depth(23)
# p t.depth(9)
# p t.depth
# t.balanced?
# t.rebalance
# t.balanced?

tree = Tree.new((Array.new(15) {rand(1..100) }))
tree.pretty_print
tree.balanced?
tree.preorder
puts
tree.postorder
puts
tree.inorder
puts
tree.insert(rand(100..1000))
tree.insert(rand(100..1000))
tree.insert(rand(100..1000))
tree.insert(rand(100..1000))
tree.insert(rand(100..1000))
tree.insert(rand(100..1000))
tree.insert(rand(100..1000))
tree.insert(rand(100..1000))
tree.pretty_print
tree.balanced?
tree.rebalance
tree.balanced?
tree.preorder
puts
tree.postorder
puts
tree.inorder
puts