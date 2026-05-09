-- 引线生产管理系统 - 数据库初始化脚本
-- 执行此脚本在 Supabase SQL Editor 中

-- 1. 创建生产记录表
CREATE TABLE IF NOT EXISTS production_records (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  entry_date DATE NOT NULL,
  work_order_no TEXT,
  material_code TEXT,
  spec TEXT,
  design_qty INTEGER DEFAULT 0,
  actual_qty INTEGER DEFAULT 0,
  good_qty INTEGER DEFAULT 0,
  loss NUMERIC DEFAULT 0,
  first_pass_rate NUMERIC DEFAULT 0,
  operator TEXT,
  notes TEXT,
  user_id UUID REFERENCES auth.users(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. 启用 Row Level Security (RLS)
ALTER TABLE production_records ENABLE ROW LEVEL SECURITY;

-- 3. 创建策略：允许用户访问自己的数据
CREATE POLICY "Users can view own records"
  ON production_records FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own records"
  ON production_records FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own records"
  ON production_records FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own records"
  ON production_records FOR DELETE
  USING (auth.uid() = user_id);

-- 4. 创建更新时间触发器
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_production_records_updated_at
  BEFORE UPDATE ON production_records
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- 5. 创建索引以提高查询性能
CREATE INDEX IF NOT EXISTS idx_production_records_user_id
  ON production_records(user_id);
CREATE INDEX IF NOT EXISTS idx_production_records_entry_date
  ON production_records(entry_date);

-- 6. 允许匿名用户访问（开发阶段，正式环境应移除）
-- 如果你希望简单登录（不依赖 Supabase Auth），可以允许匿名访问
CREATE POLICY "Allow anonymous access"
  ON production_records FOR ALL
  USING (true)
  WITH CHECK (true);

-- 完成提示
SELECT 'Database setup completed successfully!' AS status;
