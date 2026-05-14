-- 添加 customer 和 blast_rate 字段到 production_records 表
-- 执行前请先备份数据！

-- 1. 添加 customer 字段
ALTER TABLE production_records 
ADD COLUMN IF NOT EXISTS customer TEXT DEFAULT '';

-- 2. 添加 blast_rate 字段
ALTER TABLE production_records 
ADD COLUMN IF NOT EXISTS blast_rate NUMERIC(5,2) DEFAULT 0;

-- 3. 删除旧的 first_pass_defect_rate 字段（如果存在）
-- 注意：blast_rate 的公式已经改变，不再需要 first_pass_defect_rate
ALTER TABLE production_records 
DROP COLUMN IF EXISTS first_pass_defect_rate;

-- 4. 删除 actual_total 字段（如果还存在）
ALTER TABLE production_records 
DROP COLUMN IF EXISTS actual_total;

-- 验证：查看表结构
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns 
WHERE table_name = 'production_records'
ORDER BY ordinal_position;
