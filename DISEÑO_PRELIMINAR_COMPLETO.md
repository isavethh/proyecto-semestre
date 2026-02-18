# DISEÑO PRELIMINAR COMPLETO
## Super App Transporte + Delivery & TechMarket AI

**Versión:** 1.0  
**Fecha:** Febrero 2026  
**Lanzamiento previsto:** Abril 2026 (Bolivia - Santa Cruz de la Sierra)

---

## TABLA DE CONTENIDOS

1. [Resumen Ejecutivo](#1-resumen-ejecutivo)
2. [Arquitectura General del Sistema](#2-arquitectura-general-del-sistema)
3. [Módulo de Embajadores](#3-módulo-de-embajadores)
4. [Sistema IAM y Multi-tenant](#4-sistema-iam-y-multi-tenant)
5. [Catálogo de Productos y Servicios](#5-catálogo-de-productos-y-servicios)
6. [Sistema de Tickets y Soporte](#6-sistema-de-tickets-y-soporte)
7. [Motor de IA](#7-motor-de-ia)
8. [Diseño de Pantallas (Figma)](#8-diseño-de-pantallas-figma)
9. [Transacciones y Monetización](#9-transacciones-y-monetización)
10. [Seguridad y Auditoría](#10-seguridad-y-auditoría)
11. [Roadmap de Implementación](#11-roadmap-de-implementación)
12. [Modelo de Datos](#12-modelo-de-datos)
13. [KPIs y Métricas de Éxito](#13-kpis-y-métricas-de-éxito)

---

## 1. RESUMEN EJECUTIVO

### 1.1 Visión del Proyecto

El proyecto contempla dos plataformas interconectadas:

#### A) Super App Transporte + Delivery (Bolivia)
- **Objetivo:** App unificada tipo Uber + PedidosYa para Santa Cruz de la Sierra
- **Diferenciación:** Modelo de embajadores con comisiones por impacto económico real
- **Competidores:** PedidosYa, Uber, Yango, inDriver

#### B) TechMarket AI (Latinoamérica)
- **Objetivo:** Sistema Operativo Social + Comercial del sector electrónica y computación
- **Diferenciación:** Motor de compatibilidad, tickets con historial técnico, IA aplicada
- **Verticales:** Productos, servicios técnicos, repuestos, garantías

### 1.2 Principios Fundamentales

```
┌─────────────────────────────────────────────────────────────────┐
│  "No vendemos entregas ni viajes,                               │
│   vendemos ingresos, visibilidad, control y crecimiento"        │
└─────────────────────────────────────────────────────────────────┘
```

1. **El embajador gana por impacto verificable**, no por reclutar personas
2. **Transparencia total** en cálculos de comisiones
3. **Sin estigma MLM** - lenguaje de "partners económicos"
4. **IA que genera valor real**, no decorativa
5. **Multi-tenant desde el día 1**

---

## 2. ARQUITECTURA GENERAL DEL SISTEMA

### 2.1 Componentes Principales

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           ECOSISTEMA COMPLETO                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  APP CLIENTE │  │ APP NEGOCIO  │  │APP EMBAJADOR │  │  BACKOFFICE  │     │
│  │   (Móvil)    │  │ (Móvil+Web)  │  │   (Móvil)    │  │    (Web)     │     │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘     │
│         │                  │                  │                 │            │
│         └──────────────────┴──────────────────┴─────────────────┘            │
│                                    │                                         │
│                            ┌───────▼───────┐                                 │
│                            │   API GATEWAY  │                                │
│                            │   (Spring Boot)│                                │
│                            └───────┬────────┘                                │
│         ┌──────────────────────────┼────────────────────────────┐            │
│         │                          │                            │            │
│  ┌──────▼──────┐  ┌────────────────▼────────────────┐  ┌────────▼────────┐  │
│  │   IAM +     │  │     MICROSERVICIOS CORE         │  │    MOTOR IA     │  │
│  │  Multi-     │  │  ┌─────────┐ ┌─────────────┐   │  │  ┌──────────┐   │  │
│  │  tenant     │  │  │Catálogo │ │  Tickets    │   │  │  │ NLP/RAG  │   │  │
│  │             │  │  ├─────────┤ ├─────────────┤   │  │  ├──────────┤   │  │
│  │             │  │  │Embajador│ │Transacciones│   │  │  │Compat.   │   │  │
│  │             │  │  ├─────────┤ ├─────────────┤   │  │  ├──────────┤   │  │
│  │             │  │  │  CRM    │ │ Reputación  │   │  │  │Diagnóst. │   │  │
│  └─────────────┘  │  └─────────┘ └─────────────┘   │  │  └──────────┘   │  │
│                   └─────────────────────────────────┘  └─────────────────┘  │
│                                    │                                         │
│         ┌──────────────────────────┼────────────────────────────┐            │
│         │                          │                            │            │
│  ┌──────▼──────┐  ┌────────────────▼────────────────┐  ┌────────▼────────┐  │
│  │ PostgreSQL  │  │         MongoDB                 │  │     Redis       │  │
│  │   + RLS     │  │    (Documentos/Media)           │  │    (Cache)      │  │
│  └─────────────┘  └─────────────────────────────────┘  └─────────────────┘  │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

### 2.2 Stack Tecnológico

| Capa | Tecnología | Justificación |
|------|------------|---------------|
| **Backend** | Spring Boot + Spring AI | Enterprise-ready, multi-módulo |
| **BD Transaccional** | PostgreSQL + RLS | Multi-tenant con Row-Level Security |
| **BD Documentos** | MongoDB | Media, verificaciones, contenido flexible |
| **Cache** | Redis | Performance, sesiones, rate limiting |
| **Vectores IA** | pgvector / Pinecone | Embeddings para búsqueda semántica |
| **Mensajería** | Kafka / RabbitMQ | Eventos, jobs, notificaciones |
| **Mobile** | React Native / Flutter | Cross-platform |
| **Web** | React/Next.js | Backoffice y paneles |

### 2.3 Modelo Multi-tenant

```
┌─────────────────────────────────────────────────────────────────────┐
│                    ARQUITECTURA MULTI-TENANT                        │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│   Request → JWT (tenant_id, user_id, roles, scopes)                 │
│                ↓                                                     │
│   SET LOCAL app.tenant_id = 'UUID';                                 │
│                ↓                                                     │
│   PostgreSQL RLS Policy:                                            │
│   "tenant_id = current_setting('app.tenant_id')::uuid"              │
│                                                                      │
│   CAPAS DE AISLAMIENTO:                                             │
│   1. IAM (AuthN/AuthZ)                                              │
│   2. App Layer (tenant context)                                     │
│   3. DB Layer (RLS)                                                 │
│   4. Auditoría                                                      │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 3. MÓDULO DE EMBAJADORES

### 3.1 Principio Fundamental

> **"El APP Embajador es un microservicio financiero-comercial independiente cuya única función es: Visualizar, Calcular, Auditar y Cobrar ingresos generados por recomendaciones."**

### 3.2 Características Clave

| Característica | Descripción |
|----------------|-------------|
| **Independencia** | App separada, descarga independiente |
| **No obligatorio** | No es requisito para usar servicios |
| **Multi-vertical** | Funciona para todos los negocios del ecosistema |
| **3 niveles** | Comisiones en 3 niveles por impacto real |
| **Sin estigma** | Lenguaje de "Partners Económicos" |

### 3.3 Modelo de Atribución

```
┌─────────────────────────────────────────────────────────────────────┐
│                    MODELO DE ATRIBUCIÓN                             │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  MÉTODO PRINCIPAL (Automático):                                     │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐             │
│  │ Link único  │ → │  Registro   │ → │ Atribución  │              │
│  │ / QR único  │    │  automático │    │   bloqueada │              │
│  └─────────────┘    └─────────────┘    └─────────────┘             │
│                                                                      │
│  MÉTODO SECUNDARIO (Manual - respaldo):                             │
│  ┌─────────────┐    ┌─────────────┐                                 │
│  │ Campo       │ → │ Validación  │                                  │
│  │ "¿Quién te  │    │ + Bloqueo   │                                  │
│  │  invitó?"   │    │             │                                  │
│  └─────────────┘    └─────────────┘                                 │
│                                                                      │
│  REGLA DE ORO: Una vez finalizado el registro,                      │
│                la atribución queda INMUTABLE                        │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### 3.4 Cálculo de Comisiones

```
┌─────────────────────────────────────────────────────────────────────┐
│                    ESTRUCTURA DE COMISIONES                         │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  NIVEL 1: Recomendaciones directas                                  │
│  ├── Restaurantes activos: X% de ventas generadas                  │
│  ├── Conductores activos: X% de ingresos generados                 │
│  └── Usuarios activos: X% de consumo                               │
│                                                                      │
│  NIVEL 2: Recomendaciones de nivel 1                                │
│  └── Porcentaje menor sobre actividad                              │
│                                                                      │
│  NIVEL 3: Recomendaciones de nivel 2                                │
│  └── Porcentaje aún menor sobre actividad                          │
│                                                                      │
│  IMPORTANTE:                                                        │
│  • Se paga por ACTIVIDAD ECONÓMICA REAL, no por reclutamiento      │
│  • Cierres SEMANALES con períodos inmutables                       │
│  • Ledger financiero con trazabilidad completa                     │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### 3.5 Lo que NO se muestra (Anti-MLM)

| ❌ NO Mostrar | ✅ SÍ Mostrar |
|---------------|---------------|
| Árboles jerárquicos | Cantidad agregada por nivel |
| Niveles visuales (oro, diamante) | Impacto económico en Bs |
| Top afiliados públicos | Progreso personal vs. mes anterior |
| Rankings competitivos | Tendencias propias |
| Datos personales de red | Métricas anónimas |

---

## 4. SISTEMA IAM Y MULTI-TENANT

### 4.1 Roles del Sistema

```
┌─────────────────────────────────────────────────────────────────────┐
│                         ROLES Y PERMISOS                            │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  ROLES DE TENANT:                                                   │
│  ├── TENANT_OWNER      → Dueño del negocio                         │
│  ├── TENANT_ADMIN      → Administrador                              │
│  ├── BRANCH_MANAGER    → Gerente de sucursal                        │
│  ├── TECHNICIAN        → Técnico                                    │
│  ├── SALES             → Vendedor                                   │
│  └── FINANCE           → Finanzas                                   │
│                                                                      │
│  ROLES GLOBALES:                                                    │
│  ├── AMBASSADOR        → Embajador (Nivel 1)                        │
│  ├── LEADER            → Líder (Nivel 2)                            │
│  ├── MENTOR            → Mentor (Nivel 3)                           │
│  ├── MODERATOR         → Moderador de contenido                     │
│  ├── INTERNAL_SUPPORT  → Soporte interno                            │
│  └── SUPER_ADMIN       → Administrador del sistema                  │
│                                                                      │
│  ROLES DE USUARIO:                                                  │
│  ├── CLIENT            → Usuario final (busca, compra)             │
│  └── ENTERPRISE_CLIENT → Cliente empresarial                        │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### 4.2 Flujo de Autenticación

```
┌─────────────────────────────────────────────────────────────────────┐
│               FLUJO DE AUTENTICACIÓN (JWT + Refresh)                │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  1. Login → Validar credenciales                                    │
│  2. Generar Access Token (15 min) + Refresh Token (7 días)         │
│  3. Access Token contiene:                                          │
│     {                                                               │
│       "sub": "user_id",                                             │
│       "tenant_id": "uuid",                                          │
│       "branch_id": "uuid",                                          │
│       "roles": ["TENANT_ADMIN", "AMBASSADOR"],                      │
│       "scopes": ["read:catalog", "write:tickets"]                   │
│     }                                                               │
│  4. Refresh Token almacenado en BD (revocable)                     │
│  5. Cambio de contexto (switch tenant) regenera tokens             │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### 4.3 Tablas IAM

```sql
-- Tenants (Negocios)
CREATE TABLE tenant (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(100) UNIQUE,
    status VARCHAR(50), -- PENDING, VERIFIED, SUSPENDED
    verification_level VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    version INTEGER
);

-- Sucursales
CREATE TABLE tenant_branch (
    id UUID PRIMARY KEY,
    tenant_id UUID REFERENCES tenant(id),
    name VARCHAR(255),
    address TEXT,
    lat DECIMAL(10, 8),
    lng DECIMAL(11, 8),
    status VARCHAR(50),
    is_main BOOLEAN DEFAULT false
);

-- Usuarios
CREATE TABLE user_account (
    id UUID PRIMARY KEY,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(50),
    password_hash VARCHAR(255),
    email_verified BOOLEAN DEFAULT false,
    phone_verified BOOLEAN DEFAULT false,
    status VARCHAR(50), -- ACTIVE, SUSPENDED, PENDING
    created_at TIMESTAMP
);

-- Membresía Usuario-Tenant
CREATE TABLE tenant_membership (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES user_account(id),
    tenant_id UUID REFERENCES tenant(id),
    role VARCHAR(50),
    branch_id UUID,
    status VARCHAR(50),
    joined_at TIMESTAMP
);
```

---

## 5. CATÁLOGO DE PRODUCTOS Y SERVICIOS

### 5.1 Estructura del Catálogo

```
┌─────────────────────────────────────────────────────────────────────┐
│                    ARQUITECTURA DEL CATÁLOGO                        │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  REFERENCE (Global)          LISTING (Por Tenant)                   │
│  ┌─────────────────┐         ┌─────────────────────┐                │
│  │ catalog_        │         │ catalog_listing     │                │
│  │ reference_item  │ ←────── │ (publicación)       │                │
│  │                 │         │                     │                │
│  │ • Specs estándar│         │ • Precio            │                │
│  │ • Atributos     │         │ • Stock             │                │
│  │ • Marca/Modelo  │         │ • Condición         │                │
│  │ • Compatible    │         │ • Garantía          │                │
│  └─────────────────┘         │ • Fotos             │                │
│                              │ • Sucursal          │                │
│                              └─────────────────────┘                │
│                                                                      │
│  TIPOS DE CATÁLOGO:                                                 │
│  ├── PRODUCT  → Laptops, PCs, componentes, periféricos             │
│  ├── SERVICE  → Diagnóstico, reparación, armado, instalación       │
│  ├── PART     → Repuestos, pantallas, baterías, teclados           │
│  └── WARRANTY → Garantías extendidas, seguros                      │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### 5.2 Atributos por Categoría (TechMarket AI)

| Categoría | Atributos Obligatorios |
|-----------|------------------------|
| **CPU** | socket, generación, TDP, núcleos, threads |
| **Motherboard** | socket, chipset, formato (ATX/mATX/ITX), slots RAM, PCIe |
| **RAM** | tipo (DDR4/DDR5), frecuencia, latencia, capacidad, kit |
| **GPU** | largo (mm), consumo (W), conectores, VRAM |
| **PSU** | watt real, certificación (80+), conectores modulares |
| **Router** | estándar Wi-Fi, throughput, bandas, puertos |
| **Servicio** | duración estimada, categoría, nivel técnico |

### 5.3 Modelo de Datos Catálogo

```sql
-- Categorías
CREATE TABLE catalog_category (
    id UUID PRIMARY KEY,
    name VARCHAR(255),
    parent_id UUID,
    type VARCHAR(50) -- PRODUCT, SERVICE, PART
);

-- Definición de atributos por categoría
CREATE TABLE catalog_attribute_def (
    id UUID PRIMARY KEY,
    category_id UUID,
    name VARCHAR(100),
    data_type VARCHAR(50), -- STRING, NUMBER, ENUM, BOOLEAN
    is_required BOOLEAN,
    options JSONB -- Para ENUMs
);

-- Items de referencia global
CREATE TABLE catalog_reference_item (
    id UUID PRIMARY KEY,
    category_id UUID,
    brand VARCHAR(100),
    model VARCHAR(255),
    sku_global VARCHAR(100),
    attributes JSONB,
    status VARCHAR(50),
    created_at TIMESTAMP
);

-- Listings por tenant
CREATE TABLE catalog_listing (
    id UUID PRIMARY KEY,
    tenant_id UUID,
    reference_item_id UUID,
    type VARCHAR(50), -- PRODUCT, SERVICE, PART
    title VARCHAR(500),
    description TEXT,
    condition VARCHAR(50), -- NEW, USED, REFURBISHED
    state_grade VARCHAR(50), -- LIKE_NEW, GOOD, FAIR
    warranty_policy_id UUID,
    status VARCHAR(50), -- DRAFT, PUBLISHED, FLAGGED
    created_at TIMESTAMP,
    version INTEGER
);

-- Ofertas por sucursal
CREATE TABLE catalog_listing_branch_offer (
    id UUID PRIMARY KEY,
    listing_id UUID,
    branch_id UUID,
    price DECIMAL(12, 2),
    currency VARCHAR(3),
    stock_qty INTEGER,
    is_available BOOLEAN
);
```

---

## 6. SISTEMA DE TICKETS Y SOPORTE

### 6.1 Estados del Ticket

```
┌─────────────────────────────────────────────────────────────────────┐
│                    WORKFLOW DE TICKETS                              │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  NEW → TRIAGE → ASSIGNED → IN_PROGRESS → QUOTED → APPROVED         │
│   │      │                       │          │         │              │
│   │      │                       │          │         ↓              │
│   │      │                       │          │     RESOLVED          │
│   │      │                       │          │         │              │
│   │      │                       │          │         ↓              │
│   │      │                       │          │      CLOSED           │
│   │      │                       │          │                        │
│   │      │                       │          └→ REJECTED             │
│   │      │                       │                                   │
│   │      │                       └→ WAITING_CUSTOMER                │
│   │      │                       └→ WAITING_PARTS                   │
│   │      │                                                          │
│   │      └→ CANCELLED                                               │
│   │                                                                 │
│   └→ SPAM                                                           │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### 6.2 Funcionalidades del Ticket

| Funcionalidad | Descripción |
|---------------|-------------|
| **Triage IA** | Preguntas inteligentes, clasificación automática |
| **Asignación** | A técnico o equipo específico |
| **SLA** | Tiempo primera respuesta, tiempo resolución |
| **Cotización** | Items (servicios + repuestos), aprobación cliente |
| **Attachments** | Fotos, videos como evidencia |
| **Historial** | "Carpeta técnica" del equipo |
| **Notificaciones** | Estado, cotización, resolución |

### 6.3 Modelo de Datos Tickets

```sql
CREATE TABLE ticket (
    id UUID PRIMARY KEY,
    tenant_id UUID,
    branch_id UUID,
    customer_user_id UUID,
    type VARCHAR(50), -- REPAIR, SUPPORT, CONSULTATION
    status VARCHAR(50),
    priority VARCHAR(50), -- LOW, MEDIUM, HIGH, URGENT
    title VARCHAR(500),
    symptom_text TEXT,
    assigned_to_user_id UUID,
    -- SLA
    sla_first_response_due_at TIMESTAMP,
    sla_resolution_due_at TIMESTAMP,
    first_response_at TIMESTAMP,
    resolved_at TIMESTAMP,
    closed_at TIMESTAMP,
    -- Metadata
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    version INTEGER
);

CREATE TABLE ticket_comment (
    id UUID PRIMARY KEY,
    ticket_id UUID,
    user_id UUID,
    content TEXT,
    is_internal BOOLEAN, -- Solo visible para staff
    created_at TIMESTAMP
);

CREATE TABLE ticket_quotation (
    id UUID PRIMARY KEY,
    ticket_id UUID,
    status VARCHAR(50), -- DRAFT, SENT, APPROVED, REJECTED
    valid_until DATE,
    total_amount DECIMAL(12, 2),
    currency VARCHAR(3),
    terms TEXT,
    created_at TIMESTAMP
);

CREATE TABLE ticket_quotation_item (
    id UUID PRIMARY KEY,
    quotation_id UUID,
    type VARCHAR(50), -- SERVICE, PART
    description VARCHAR(500),
    quantity INTEGER,
    unit_price DECIMAL(12, 2),
    listing_id UUID -- Referencia a catálogo si aplica
);
```

---

## 7. MOTOR DE IA

### 7.1 Funcionalidades de IA Priorizadas

#### PRIORIDAD ALTA (MVP - V1)

| Feature | Descripción | Impacto |
|---------|-------------|---------|
| **Recomendaciones contextuales** | Sugerencias según hora, clima, ubicación, historial | +Uso, +Conversión |
| **Rankings locales dinámicos** | "Top Equipetrol ahora", "Mejor precio-calidad zona" | +Confianza |
| **Optimización de gasto** | Alternativas económicas, combos convenientes | +Retención |
| **Predicción de demanda** | Picos por día/hora para restaurantes | -Pérdidas |
| **Análisis de platos rentables** | Identificar margen vs. volumen | +Ingresos negocio |
| **Zonas calientes (conductores)** | Mapas de calor de demanda | +Ingresos conductor |
| **Oportunidades detectadas (embajadores)** | Zonas sin cobertura, negocios potenciales | +Expansión |

#### PRIORIDAD MEDIA (V2 / Premium)

| Feature | Descripción |
|---------|-------------|
| **Sugerencias de promociones** | Detectar baja demanda, recomendar descuentos |
| **Combinación inteligente viaje/pedido** | Secuencias eficientes para conductores |
| **Intent Search avanzado** | Búsqueda por intención natural |
| **Diagnóstico preliminar IA** | Triage inteligente para tickets |

#### ❌ NO IMPLEMENTAR EN V1

| Feature | Razón |
|---------|-------|
| Chatbots conversacionales | No genera conversión temprana |
| IA emocional / avatares | Complejidad sin valor |
| Análisis financiero tipo ERP | Overkill para MVP |
| Gamificación compleja | Refuerza estigma MLM |

### 7.2 Arquitectura IA

```
┌─────────────────────────────────────────────────────────────────────┐
│                    ARQUITECTURA DEL MOTOR IA                        │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  ┌─────────────────────────────────────────────────────────┐        │
│  │                    SPRING AI                             │        │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │        │
│  │  │   OpenAI    │  │   Ollama    │  │  Embeddings │     │        │
│  │  │   (GPT-4)   │  │  (Local)    │  │  (pgvector) │     │        │
│  │  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘     │        │
│  └─────────┼────────────────┼────────────────┼─────────────┘        │
│            │                │                │                       │
│  ┌─────────▼────────────────▼────────────────▼─────────────┐        │
│  │                 CASOS DE USO IA                          │        │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │        │
│  │  │ Intent      │  │ Compatibil. │  │ Triage      │     │        │
│  │  │ Search      │  │ PC Builder  │  │ Tickets     │     │        │
│  │  ├─────────────┤  ├─────────────┤  ├─────────────┤     │        │
│  │  │ Recomend.   │  │ Pricing     │  │ Oportunid.  │     │        │
│  │  │ Usuarios    │  │ Anomalías   │  │ Embajadores │     │        │
│  │  └─────────────┘  └─────────────┘  └─────────────┘     │        │
│  └──────────────────────────────────────────────────────────┘        │
│                                                                      │
│  ENFOQUE: Reglas inteligentes + ML ligero (no modelos pesados)     │
│  PRINCIPIO: "Comienza con heurísticas, evoluciona con datos"       │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 8. DISEÑO DE PANTALLAS (FIGMA)

### 8.1 Flujo de Onboarding del Embajador

```
┌─────────────────────────────────────────────────────────────────────┐
│                FLUJO DE REGISTRO - EMBAJADOR                        │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  PASO 0: Entry Point (Invisible)                                    │
│  ├── Detectar ref_id (link/QR/manual)                              │
│  ├── Guardar en sesión                                              │
│  └── Si no existe → registro directo (red empresa)                 │
│                                                                      │
│  PASO 1: Registro Básico                                            │
│  ├── Nombre, email, teléfono, contraseña                           │
│  ├── Campo opcional: "Código de invitación"                        │
│  └── Validar unicidad email/teléfono                               │
│                                                                      │
│  PASO 2: Verificación de Cuenta                                     │
│  ├── Verificar correo (link magic)                                 │
│  └── Verificar teléfono (OTP SMS)                                  │
│                                                                      │
│  PASO 3: Completar Perfil                                           │
│  ├── Tipo documento, número                                         │
│  ├── Ubicación (ciudad, zona)                                       │
│  ├── Tipo de recomendación (restaurantes/conductores/usuarios)     │
│  └── Declaraciones y aceptaciones                                  │
│                                                                      │
│  PASO 4: Método de Pago                                             │
│  ├── Transferencia bancaria / Billetera digital                    │
│  ├── Banco, tipo cuenta, número, titular                           │
│  └── Confirmación de datos correctos                               │
│                                                                      │
│  PASO 5: Bienvenida Profesional                                     │
│  ├── Explicación del programa (sin estigma MLM)                    │
│  ├── Qué es y qué NO es                                            │
│  ├── Cómo se generan ingresos                                      │
│  └── Checkbox: "Entiendo cómo funciona el programa"                │
│                                                                      │
│  → ACCESO AL BACKOFFICE                                             │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### 8.2 Pantallas del Backoffice Embajador

#### DASHBOARD PRINCIPAL

```
┌─────────────────────────────────────────────────────────────────────┐
│  [Logo]           Dashboard          [Notif] [Perfil]               │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐       │
│  │ Impacto Total   │ │ Ingresos Mes    │ │ Próx. Cierre    │       │
│  │ Bs 24,500       │ │ Bs 1,230        │ │ 3 días          │       │
│  │ ↑ 18% vs ant.   │ │ ↑ 12% vs ant.   │ │ Lun 15/03       │       │
│  └─────────────────┘ └─────────────────┘ └─────────────────┘       │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │ Actividad por Tipo                                           │   │
│  │ ┌──────────┐ ┌──────────┐ ┌──────────┐                      │   │
│  │ │🍽️ Rest.  │ │🚗 Cond.  │ │👤 Usuar. │                      │   │
│  │ │ 4 activos│ │ 7 activos│ │ 23 activ.│                      │   │
│  │ └──────────┘ └──────────┘ └──────────┘                      │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │ Accesos Rápidos                                              │   │
│  │ [Invitar] [Mi Impacto] [Oportunidades] [Misiones]           │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │ 💡 Insight IA: "Tu impacto creció 18% respecto al mes       │   │
│  │    pasado. La mayor parte proviene de restaurantes activos" │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                      │
├─────────────────────────────────────────────────────────────────────┤
│  [🏠] [📊] [🎯] [📚] [⚙️]                                           │
└─────────────────────────────────────────────────────────────────────┘
```

#### INGRESOS Y ACTIVIDAD

```
┌─────────────────────────────────────────────────────────────────────┐
│  ← Ingresos y Actividad                    [Semana ▼]              │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  Ingresos del periodo: Bs 1,230.50                                  │
│  Estado: Pendiente de pago                                          │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │ Desglose por nivel                                           │   │
│  │ ─────────────────────────────────────────────────────────── │   │
│  │ Nivel 1:  Bs 6,200 ventas × 5% = Bs 310.00                  │   │
│  │ Nivel 2:  Bs 9,800 ventas × 3% = Bs 294.00                  │   │
│  │ Nivel 3:  Bs 25,600 ventas × 2% = Bs 512.00                 │   │
│  │ ─────────────────────────────────────────────────────────── │   │
│  │ Bonos adicionales:              Bs 114.50                   │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │ Historial de actividad                                       │   │
│  │ ┌─────────┬────────────┬──────────┬─────────┬──────────┐   │   │
│  │ │ Fecha   │ Tipo       │ Origen   │ Impacto │ Ingreso  │   │   │
│  │ ├─────────┼────────────┼──────────┼─────────┼──────────┤   │   │
│  │ │ 10/02   │ Pedido     │ Rest. X  │ Bs 45   │ Bs 2.25  │   │   │
│  │ │ 10/02   │ Viaje      │ Cond. Y  │ Bs 30   │ Bs 1.50  │   │   │
│  │ │ 09/02   │ Activación │ Rest. Z  │ -       │ Bs 50.00 │   │   │
│  │ └─────────┴────────────┴──────────┴─────────┴──────────┘   │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  [📥 Exportar PDF]  [📊 Exportar Excel]                             │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

#### INVITAR / RECOMENDAR

```
┌─────────────────────────────────────────────────────────────────────┐
│  ← Invitar / Recomendar                                             │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  "Comparte tu enlace exclusivo para que tus recomendaciones         │
│   se atribuyan automáticamente"                                     │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │ 🔗 Tu enlace personal                                        │   │
│  │ ┌───────────────────────────────────────────────────────┐   │   │
│  │ │ https://app.example.com/r/AF-12345                    │   │   │
│  │ └───────────────────────────────────────────────────────┘   │   │
│  │ [📋 Copiar enlace]  [📤 Compartir]                          │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │ 📱 Tu código QR                                              │   │
│  │                                                              │   │
│  │            ┌─────────────────┐                               │   │
│  │            │   [QR CODE]     │                               │   │
│  │            │                 │                               │   │
│  │            │   AF-12345      │                               │   │
│  │            └─────────────────┘                               │   │
│  │                                                              │   │
│  │ [💾 Descargar QR]  [📤 Compartir QR]                        │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │ 🔢 Tu código manual (respaldo)                               │   │
│  │ Código: AF-12345                                             │   │
│  │ "Solo usa esto si el registro no es desde tu link/QR"       │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  ℹ️ "Las recomendaciones se atribuyen automáticamente cuando       │
│     se usa tu enlace o QR. La atribución no puede modificarse."    │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

#### OPORTUNIDADES DETECTADAS (IA)

```
┌─────────────────────────────────────────────────────────────────────┐
│  ← Oportunidades Detectadas                [🔍 Filtros]             │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  "Sugerencias basadas en datos reales del ecosistema"               │
│                                                                      │
│  [Todas ▼]  [Restaurantes]  [Conductores]  [Zona ▼]                │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │ 🍽️ Zona Equipetrol                                    [📍]   │   │
│  │ "Alta demanda de pedidos nocturnos sin restaurantes          │   │
│  │  afiliados en la zona"                                       │   │
│  │ Potencial estimado: Alto                                     │   │
│  │ [⭐ Guardar]  [✓ Ya lo atendí]                               │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │ 🚗 Zona Plan 3000                                     [📍]   │   │
│  │ "Baja cobertura de conductores en horarios matutinos"        │   │
│  │ Potencial estimado: Medio                                    │   │
│  │ [⭐ Guardar]  [✓ Ya lo atendí]                               │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │ 🍽️ Restaurante "El Buen Sabor"                        [📍]   │   │
│  │ "Restaurante popular sin presencia en plataforma"            │   │
│  │ Potencial estimado: Alto                                     │   │
│  │ [⭐ Guardar]  [✓ Ya lo atendí]                               │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  ℹ️ "Estas oportunidades se actualizan automáticamente.            │
│     Las sugerencias no garantizan resultados específicos."         │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

#### MISIONES DE VALOR

```
┌─────────────────────────────────────────────────────────────────────┐
│  ← Misiones de Valor                                                │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  "Acciones recomendadas para maximizar tu impacto"                  │
│                                                                      │
│  [Todas]  [Restaurantes]  [Conductores]  [Usuarios]                │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │ 🎯 Expandir cobertura gastronómica          En progreso     │   │
│  │ ──────────────────────────────────────────────────────────  │   │
│  │ "Incorpora 2 restaurantes en zona Norte"                     │   │
│  │                                                              │   │
│  │ Beneficio: Bono de Bs 100 por cada restaurante activo       │   │
│  │ Progreso: 1/2 completado                                     │   │
│  │ ████████████░░░░░░░░░░ 50%                                  │   │
│  │                                                              │   │
│  │ [👁️ Ver detalles]                                           │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │ 🎯 Activar conductores nocturnos              Disponible    │   │
│  │ ──────────────────────────────────────────────────────────  │   │
│  │ "Activa 3 conductores que operen después de las 8pm"        │   │
│  │                                                              │   │
│  │ Beneficio: Bono extra del 2% en comisiones nocturnas        │   │
│  │ Tiempo límite: 15 días                                       │   │
│  │                                                              │   │
│  │ [✓ Aceptar misión]                                          │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  ℹ️ "Las misiones son opcionales. Completar misiones no            │
│     garantiza ingresos específicos."                               │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### 8.3 Navegación Principal (Tab Bar)

```
┌─────────────────────────────────────────────────────────────────────┐
│                                                                      │
│  [🏠 Inicio]  [📊 Impacto]  [🎯 Misiones]  [📚 Educación]  [⚙️ Más] │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘

Sección "Más":
├── Invitar / Recomendar
├── Historial y Reportes
├── Perfil y Configuración
├── Centro de Ayuda
├── Avisos Legales
└── Cerrar Sesión
```

---

## 9. TRANSACCIONES Y MONETIZACIÓN

### 9.1 Modelo de Monetización

```
┌─────────────────────────────────────────────────────────────────────┐
│                    MODELO DE MONETIZACIÓN                           │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  FREEMIUM (Base):                                                   │
│  ├── Perfil + catálogo básico                                      │
│  ├── Presencia en mapa y búsqueda                                  │
│  ├── Operación básica de tickets                                   │
│  └── Dashboard simple                                               │
│                                                                      │
│  PREMIUM (Suscripción mensual):                                     │
│  ├── Mayor visibilidad (boost en ranking)                          │
│  ├── Perfil avanzado (más fotos, videos, badges)                   │
│  ├── Herramientas CRM potentes                                     │
│  ├── Analítica avanzada                                            │
│  ├── Automatizaciones (follow-ups, promos)                         │
│  └── Soporte prioritario                                           │
│                                                                      │
│  PERFORMANCE (Comisiones):                                          │
│  ├── Comisión por lead calificado convertido                       │
│  ├── Comisión por transacción completada                           │
│  └── Revenue share en servicios especiales                         │
│                                                                      │
│  EMBAJADORES:                                                       │
│  ├── Comisiones por negocios registrados y verificados             │
│  ├── Comisiones por activaciones premium                           │
│  ├── Comisiones por actividad económica (3 niveles)                │
│  └── Bonos por misiones completadas                                │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### 9.2 Ledger Financiero

```sql
-- Ledger de transacciones (inmutable)
CREATE TABLE ledger_entry (
    id UUID PRIMARY KEY,
    tenant_id UUID,
    type VARCHAR(50), -- CREDIT, DEBIT
    category VARCHAR(100), -- SUBSCRIPTION, COMMISSION, PAYOUT, etc.
    amount DECIMAL(12, 2),
    currency VARCHAR(3),
    reference_type VARCHAR(100), -- SUBSCRIPTION, AMBASSADOR_COMMISSION, etc.
    reference_id UUID,
    balance_after DECIMAL(12, 2),
    description TEXT,
    created_at TIMESTAMP,
    -- Inmutable: no update, no delete
    CONSTRAINT no_negative_balance CHECK (balance_after >= 0)
);

-- Cierres periódicos (embajadores)
CREATE TABLE ambassador_payout_cycle (
    id UUID PRIMARY KEY,
    ambassador_user_id UUID,
    period_start DATE,
    period_end DATE,
    total_impact DECIMAL(12, 2),
    total_commission DECIMAL(12, 2),
    level1_amount DECIMAL(12, 2),
    level2_amount DECIMAL(12, 2),
    level3_amount DECIMAL(12, 2),
    bonuses DECIMAL(12, 2),
    status VARCHAR(50), -- OPEN, CALCULATED, APPROVED, PAID
    paid_at TIMESTAMP,
    payment_method_id UUID,
    payment_reference VARCHAR(255),
    created_at TIMESTAMP
);
```

---

## 10. SEGURIDAD Y AUDITORÍA

### 10.1 Capas de Seguridad

```
┌─────────────────────────────────────────────────────────────────────┐
│                    CAPAS DE SEGURIDAD                               │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  CAPA 1: AUTENTICACIÓN                                              │
│  ├── JWT Access Token (15 min) + Refresh Token (BD)                │
│  ├── MFA opcional (2FA)                                             │
│  ├── Rate limiting por IP y usuario                                │
│  └── Detección de sesiones anómalas                                │
│                                                                      │
│  CAPA 2: AUTORIZACIÓN                                               │
│  ├── RBAC (Role-Based Access Control)                              │
│  ├── ABAC (Attribute-Based) para reglas complejas                  │
│  ├── Scopes granulares en tokens                                   │
│  └── Validación tenant_id en cada request                          │
│                                                                      │
│  CAPA 3: AISLAMIENTO DE DATOS                                       │
│  ├── Row-Level Security (RLS) en PostgreSQL                        │
│  ├── Políticas por tenant_id                                       │
│  └── SET LOCAL app.tenant_id en cada transacción                   │
│                                                                      │
│  CAPA 4: AUDITORÍA                                                  │
│  ├── Log de todas las acciones sensibles                           │
│  ├── Quién, qué, cuándo, desde dónde                               │
│  ├── Ledger financiero inmutable                                   │
│  └── Retención de logs según compliance                            │
│                                                                      │
│  CAPA 5: ANTIFRAUDE                                                 │
│  ├── Detección de auto-invitaciones                                │
│  ├── Patrones anómalos de registro                                 │
│  ├── Validación de dispositivos                                    │
│  └── Alertas y bloqueos automáticos                                │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### 10.2 Políticas RLS

```sql
-- Habilitar RLS en tablas de negocio
ALTER TABLE catalog_listing ENABLE ROW LEVEL SECURITY;

-- Política para aislar datos por tenant
CREATE POLICY tenant_isolation ON catalog_listing
    USING (tenant_id = current_setting('app.tenant_id')::uuid);

-- Política para lectura pública (marketplace)
CREATE POLICY public_read ON catalog_listing
    FOR SELECT
    USING (status = 'PUBLISHED');
```

### 10.3 Auditoría

```sql
CREATE TABLE audit_log (
    id UUID PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT NOW(),
    user_id UUID,
    tenant_id UUID,
    action VARCHAR(100), -- CREATE, UPDATE, DELETE, LOGIN, EXPORT, etc.
    entity_type VARCHAR(100),
    entity_id UUID,
    old_value JSONB,
    new_value JSONB,
    ip_address INET,
    user_agent TEXT,
    session_id UUID
);
```

---

## 11. ROADMAP DE IMPLEMENTACIÓN

### 11.1 Fases del Proyecto

```
┌─────────────────────────────────────────────────────────────────────┐
│              ROADMAP DE IMPLEMENTACIÓN (90-180 días)                │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  FASE 0: FUNDAMENTOS (Semanas 1-2)                                  │
│  ├── IAM funcionando (login, roles, JWT)                           │
│  ├── Multi-tenant context + RLS                                    │
│  ├── Base de datos operativa (Postgres + Mongo + Redis)            │
│  ├── Skeleton apps (web + mobile)                                  │
│  ├── CI/CD básico                                                  │
│  └── ✓ Éxito: Aislamiento cross-tenant probado                    │
│                                                                      │
│  FASE 1: MVP NEGOCIO (Semanas 3-6)                                  │
│  ├── Registro tenant + sucursal                                    │
│  ├── Verificación mínima                                           │
│  ├── Catálogo listings con publicación guiada                      │
│  ├── App cliente: mapa, lista, ficha, contacto                     │
│  ├── Dashboard propietario mínimo                                  │
│  └── ✓ Éxito: Usuario encuentra negocio y contacta                │
│                                                                      │
│  FASE 2: OPERACIÓN (Semanas 7-10)                                   │
│  ├── Tickets con workflow                                          │
│  ├── Attachments y evidencias                                      │
│  ├── Cotizaciones y aprobación                                     │
│  ├── Notificaciones (push, email, WhatsApp)                        │
│  └── ✓ Éxito: Tickets cerrados correctamente                      │
│                                                                      │
│  FASE 3: IA CORE (Semanas 11-14)                                    │
│  ├── Intent search con ranking híbrido                             │
│  ├── Recomendaciones contextuales                                  │
│  ├── Oportunidades detectadas                                      │
│  └── ✓ Éxito: Mejora CTR vs búsqueda tradicional                  │
│                                                                      │
│  FASE 4: MONETIZACIÓN (Semanas 15-18)                               │
│  ├── Suscripción premium                                           │
│  ├── Invoices y facturación                                        │
│  ├── Performance charges                                           │
│  └── ✓ Éxito: Ingresos recurrentes activos                        │
│                                                                      │
│  FASE 5: EMBAJADORES (Semanas 19-22)                                │
│  ├── Atribución completa                                           │
│  ├── Comisiones event-driven                                       │
│  ├── Payout cycles                                                 │
│  ├── Antifraude                                                    │
│  └── ✓ Éxito: Embajadores cobrando correctamente                  │
│                                                                      │
│  FASE 6: ESCALA (Semanas 23+)                                       │
│  ├── Backoffice admin completo                                     │
│  ├── Analytics dashboards                                          │
│  ├── Moderación avanzada                                           │
│  └── Expansión geográfica                                          │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### 11.2 MVP Brutal (90 días)

| Componente | Entregables |
|------------|-------------|
| **App Cliente** | Intent search + mapa + perfiles + WhatsApp + favoritos |
| **App Propietario** | Catálogo + tickets básicos + promos |
| **Embajador** | Onboarding + atribución + dashboard + cierres + payout |
| **IA** | Compatibilidad básica + recomendaciones simples |

---

## 12. MODELO DE DATOS

### 12.1 Distribución por Base de Datos

```
┌─────────────────────────────────────────────────────────────────────┐
│                    DISTRIBUCIÓN DE DATOS                            │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  POSTGRESQL (Transaccional + RLS):                                  │
│  ├── Tenants, usuarios, membresías                                 │
│  ├── Catálogo (references, listings, offers)                       │
│  ├── Tickets, cotizaciones                                         │
│  ├── Embajadores, atribuciones, comisiones                         │
│  ├── Transacciones, suscripciones, pagos                           │
│  ├── Ledger financiero                                             │
│  └── Audit logs                                                    │
│                                                                      │
│  MONGODB (Documentos flexibles):                                    │
│  ├── Media (fotos, thumbnails, metadatos)                          │
│  ├── Documentos de verificación                                    │
│  ├── Contenido educativo                                           │
│  ├── Historial de conversaciones                                   │
│  └── Evidencias de tickets                                         │
│                                                                      │
│  REDIS (Cache + Performance):                                       │
│  ├── Sesiones de usuario                                           │
│  ├── Cache de búsquedas                                            │
│  ├── Rate limiting                                                 │
│  ├── Contadores en tiempo real                                     │
│  └── Colas de jobs                                                 │
│                                                                      │
│  PGVECTOR (Embeddings IA):                                          │
│  ├── Embeddings de productos                                       │
│  ├── Embeddings de búsquedas                                       │
│  └── Vectores de compatibilidad                                    │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

### 12.2 Diagrama ER Principal

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         MODELO ENTIDAD-RELACIÓN                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────────┐     ┌──────────────┐     ┌──────────────┐                 │
│  │   TENANT     │────<│TENANT_BRANCH │     │ USER_ACCOUNT │                 │
│  │   (negocio)  │     │ (sucursales) │     │  (usuarios)  │                 │
│  └──────┬───────┘     └──────────────┘     └──────┬───────┘                 │
│         │                                          │                         │
│         │         ┌──────────────────┐            │                         │
│         └────────>│TENANT_MEMBERSHIP │<───────────┘                         │
│                   │  (user ↔ tenant) │                                       │
│                   └──────────────────┘                                       │
│                                                                              │
│  ┌──────────────┐     ┌──────────────┐     ┌──────────────┐                 │
│  │   CATALOG    │────<│   CATALOG    │────<│   BRANCH     │                 │
│  │  REFERENCE   │     │   LISTING    │     │    OFFER     │                 │
│  │  (plantilla) │     │ (publicación)│     │(precio/stock)│                 │
│  └──────────────┘     └──────────────┘     └──────────────┘                 │
│                                                                              │
│  ┌──────────────┐     ┌──────────────┐     ┌──────────────┐                 │
│  │   TICKET     │────<│   TICKET     │     │   TICKET     │                 │
│  │              │     │   COMMENT    │     │  QUOTATION   │                 │
│  └──────────────┘     └──────────────┘     └──────────────┘                 │
│                                                                              │
│  ┌──────────────┐     ┌──────────────┐     ┌──────────────┐                 │
│  │  AMBASSADOR  │────<│ AMBASSADOR   │────<│   PAYOUT     │                 │
│  │  ATTRIBUTION │     │  COMMISSION  │     │    CYCLE     │                 │
│  └──────────────┘     └──────────────┘     └──────────────┘                 │
│                                                                              │
│  ┌──────────────┐     ┌──────────────┐                                      │
│  │ SUBSCRIPTION │────<│LEDGER_ENTRY  │                                      │
│  │              │     │ (inmutable)  │                                      │
│  └──────────────┘     └──────────────┘                                      │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 13. KPIs Y MÉTRICAS DE ÉXITO

### 13.1 KPIs de Negocio

| Métrica | Descripción | Target Piloto |
|---------|-------------|---------------|
| **Negocios activos** | Tenants con actividad mensual | 100+ |
| **Leads generados** | Contactos iniciados por usuarios | 500/mes |
| **Tickets creados** | Solicitudes de servicio | 200/mes |
| **Tasa de respuesta** | % respuestas < 24h | > 80% |
| **Premium mensual** | Suscripciones activas | 20%+ de tenants |
| **NPS** | Net Promoter Score | > 30 |

### 13.2 KPIs de Embajadores

| Métrica | Descripción | Target |
|---------|-------------|--------|
| **Embajadores activos** | Con actividad en últimos 30 días | 50+ |
| **Negocios registrados/embajador** | Promedio de registros | 3+ |
| **Tasa de activación** | Registros → Negocios activos | > 60% |
| **Comisiones pagadas** | Total semanal | Creciente |
| **Retención embajadores** | % activos mes a mes | > 70% |

### 13.3 KPIs Técnicos

| Métrica | Descripción | Target |
|---------|-------------|--------|
| **Uptime** | Disponibilidad del sistema | 99.5%+ |
| **Response time P95** | Latencia percentil 95 | < 500ms |
| **Error rate** | % de errores 5xx | < 0.1% |
| **Deploy frequency** | Despliegues por semana | 2+ |
| **Lead time** | Tiempo commit → producción | < 1 día |

---

## ANEXOS

### A. Checklist de Implementación

- [ ] IAM + Multi-tenant configurado
- [ ] RLS activado en todas las tablas de tenant
- [ ] Flujo de onboarding embajador completo
- [ ] Sistema de atribución automática (link/QR)
- [ ] Cálculo de comisiones 3 niveles
- [ ] Ledger financiero inmutable
- [ ] Dashboard embajador (6 pantallas principales)
- [ ] Sistema de tickets con workflow
- [ ] Catálogo con categorías y atributos
- [ ] Motor de búsqueda con IA básica
- [ ] Notificaciones (push/email/WhatsApp)
- [ ] Backoffice admin
- [ ] Antifraude básico
- [ ] Exportación de reportes
- [ ] Centro de ayuda y FAQs

### B. Glosario

| Término | Definición |
|---------|------------|
| **Embajador** | Usuario que recomienda negocios/usuarios y gana por impacto |
| **Tenant** | Negocio registrado en la plataforma |
| **Atribución** | Proceso de asignar una recomendación a un embajador |
| **Impacto** | Actividad económica generada por recomendaciones |
| **Cierre** | Período semanal donde se calculan comisiones |
| **Ledger** | Registro financiero inmutable |
| **RLS** | Row-Level Security (aislamiento de datos en BD) |

### C. Referencias de Documentos

1. MODULO EMBAJADOR.docx - Flujos completos de registro y backoffice
2. Tech Market AI Capítulos 1-18 - Arquitectura técnica completa
3. Documentos Figma 1-16 - Diseño de pantallas detallado
4. Documentos A-G - Estrategia de diferenciación y features IA

---

**Documento generado:** Febrero 2026  
**Versión:** 1.0  
**Estado:** Diseño Preliminar Completo

---

*Este documento consolida todos los requisitos de los documentos proporcionados y sirve como guía técnica y funcional para el desarrollo del proyecto.*
