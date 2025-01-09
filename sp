from collections import defaultdict, deque

def build_process_tree(pairs):
    tree = {}
    tree_keys = []
    roots = []

    # Build the tree while tracking root
    for pid, ppid in pairs:
        if not(ppid in tree_keys):
            tree[ppid] = {
                "content": "",
                "childs": [pid]
            }

            roots.append(ppid)
        else:
            tree[ppid]["childs"].append(pid)

        tree_keys.append(ppid)

        if pid in tree_keys:
            tree[pid]["content"] = f"parent is {ppid} - process id is {pid}"

            if pid != ppid:
                roots.remove(pid)

    return tree, roots

def print_tree(tree, roots):
    # Use BFS (iterative) to print the tree level by level
    queue = deque([(root, 0)])  # (pid, level)
    while queue:
        pid, level = queue.popleft()
        print(pid, level)  # Indentation based on level
        for child_pid in tree[pid]:
            queue.append((child_pid, level + 1))

# Example usage:
process_data = [
    (0,0),
    (4,0),
    (88,4),
    (296,4),
    (1616,4),
    (408,396),
    (480,396),
    (620,480),
    (312,620),
    (3552,312),
    (4556,312),
    (352,620),
    (428,620),
    (744,620),
    (512,744),
    (2152,744),
    (488,472),
    (556,472),
    (780,556),
    (1008,556),
    (4764,4648),
    (576,4764),
    (2104,4764),
    (2148,4764),
    (3256,2148),
    (1200,3156),
    (1540,1200),
    (8128,2148),
    (2700,4764),
    (6384,4764),
    (7880,4764),
    (7232,3824),
    (7548,7232),
    (7324,6716),
    (7540,7324),
    (8076,6768)
]

process_data = sorted(process_data, key=lambda x:min(x[0], x[1]))
print(process_data)
tree, root = build_process_tree(process_data)
print("Process Tree:")
for pid in root:
    print(pid, tree[pid])
