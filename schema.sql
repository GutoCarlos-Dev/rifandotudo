-- 1. Atualizar a tabela de Rifas com os novos campos de contato
ALTER TABLE raffles ADD COLUMN IF NOT EXISTS creator_name TEXT;
ALTER TABLE raffles ADD COLUMN IF NOT EXISTS whatsapp_contact TEXT;

-- 2. Garantir que a tabela de tickets existe com a estrutura necessária
CREATE TABLE IF NOT EXISTS tickets (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    raffle_id UUID REFERENCES raffles(id) ON DELETE CASCADE NOT NULL,
    number_selected INTEGER NOT NULL,
    buyer_name TEXT NOT NULL,
    buyer_phone TEXT NOT NULL,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'paid', 'cancelled')),
    
    -- REGRA DE OURO: Impede que o mesmo número seja vendido duas vezes na mesma rifa
    CONSTRAINT unique_ticket_per_raffle UNIQUE(raffle_id, number_selected)
);

-- 3. Habilitar o Realtime para a tabela de tickets (opcional, mas recomendado)
-- Isso permite que a grade de números atualize quase instantaneamente para outros usuários
alter publication supabase_realtime add table tickets;

-- 4. Ajustar permissões (Rls - Row Level Security)
-- Permite que qualquer pessoa insira tickets (faça reservas)
CREATE POLICY "Permitir reservas públicas" ON tickets FOR INSERT WITH CHECK (true);

-- Permite que qualquer pessoa veja os tickets (para saber quais números estão ocupados)
CREATE POLICY "Permitir leitura pública de tickets" ON tickets FOR SELECT USING (true);